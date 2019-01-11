#!/usr/bin/env python

from __future__ import print_function

import os
import shutil
import subprocess
import sys

class LogSection:
    """ A utility for creating log sections. """

    _is_first_section = True

    def __init__(self, header):
        self.header = header
        self.stdout = sys.stdout

    def __enter__(self):
        sys.stdout = self

    def __exit__(self, type, value, traceback):
        sys.stdout = self.stdout

    def _write_header(self):
        if self.header:
            if LogSection._is_first_section:
                LogSection._is_first_section = False
            else:
                self.stdout.write("\n")

            self.stdout.write(self.header)
            self.stdout.write("\n")
            self.header = None

    def write(self, *args):
        self._write_header()
        self.stdout.write("    ")
        self.stdout.write(*args)

def call(cmd):
    """ Calls the provided shell command. """
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE)
    for line in proc.stdout:
        print(line.rstrip())

def expand(path):
    """ Expands the provided path to an absolute path. """
    return os.path.expandvars(os.path.expanduser(path))

def expanded_paths(paths):
    """ Helper for iterating safely over the provided paths. """
    for path in paths:
        path = expand(path)
        if not os.path.exists(path):
            print("Skipping invalid path:", path)
            continue
        yield path

def clean(symlink_dirs):
    """ Cleans up anything from older dotfile installs. """
    with LogSection("Cleaning up..."):
        for path in expanded_paths(symlink_dirs):
            for item in sorted(os.listdir(path)):
                item = os.path.join(path, item)
                if os.path.islink(item) and not os.path.exists(item):
                    print("Removing symlink:", item)
                    os.remove(item)

        fzf_dir = expand("~/.fzf")
        if os.path.exists(fzf_dir):
            print("Removing: ~/.fzf")
            shutil.rmtree(fzf_dir)

def backup(path):
    """ If the path exists, backs it up. """
    dst = path + ".bak"
    print("{} -> {}".format(path, dst))
    shutil.move(path, path + ".bak")

def link(paths):
    """ Symlinks the provided paths. """
    with LogSection("Setting up symlinks..."):
        dotfile_dir = os.path.dirname(os.path.realpath(__file__))
        for src, dst in sorted(paths.iteritems(), key=lambda (k,v): k):
            src = expand(os.path.join(dotfile_dir, src))
            dst = expand(dst)
            if os.path.exists(dst):
                if os.path.islink(dst):
                    os.remove(dst)
                else:
                    backup(dst)
            else:
                parent = os.path.dirname(dst)
                if not os.path.exists(parent):
                    os.makedirs(os.path.dirname(dst))
            print("{} -> {}".format(src, dst))
            os.symlink(src, dst)

def create(paths):
    """ Creates the provided paths if they don't exist. """
    with LogSection("Creating directories..."):
        for path in paths:
            path = expand(path)
            if not os.path.exists(path):
                print("Creating:", path)
                os.makedirs(path)

def init_submodules():
    """ Initializes git submodules. """
    with LogSection("Initializing submodules..."):
        call(["git", "submodule", "update", "--init"])

def init_fzf():
    """ Initializes fzf. """
    with LogSection("Initializing fzf..."):
        dotfile_dir = os.path.dirname(os.path.realpath(__file__))
        install_script = os.path.join(dotfile_dir, "fzf", "install")
        call([install_script, "--bin"])

def main(args):
    clean(["~", "~/.config"])
    init_submodules()
    init_fzf()
    link({
        "bashrc": "~/.bashrc",
        "fish": "~/.config/fish",
        "git/config": "~/.gitconfig",
        "tmux/tmux.conf": "~/.tmux.conf",
        "vim": "~/.vim",
    })
    create(["~/.vim/swp", "~/.vim/undo"])
    return 0

if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
