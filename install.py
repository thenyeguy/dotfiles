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
        print(line)

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

def clean(paths):
    """ Cleans up broken symlinks in the provided directories. """
    with LogSection("Cleaning up dead symlinks..."):
        for path in expanded_paths(paths):
            for item in sorted(os.listdir(path)):
                item = os.path.join(path, item)
                if os.path.islink(item) and not os.path.exists(item):
                    print("Removing symlink:", item)
                    os.remove(item)

def backup(path):
    """ If the path exists, backs it up. """
    dst = path + ".bak"
    print("{} -> {}".format(path, dst))
    shutil.move(path, path + ".bak")

def link(paths):
    """ Symlinks the provided paths. """
    with LogSection("Setting up symlinks..."):
        dotfile_dir = os.path.dirname(os.path.realpath(__file__))
        for src, dst in paths.iteritems():
            src = expand(os.path.join(dotfile_dir, src))
            dst = expand(dst)
            if os.path.exists(dst):
                if os.path.islink(dst):
                    os.remove(dst)
                else:
                    backup(dst)
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

def main(args):
    clean(["~", "~/.config"])
    init_submodules()
    link({
        "bashrc": "~/.bashrc",
        "fish": "~/.config/fish",
        "gitconfig": "~/.gitconfig",
        "hgrc": "~/.hgrc",
        "tmux/tmux.conf": "~/.tmux.conf",
        "vim": "~/.vim",
    })
    create(["~/.vim/swp", "~/.vim/undo"])
    return 0

if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
