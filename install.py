#!/usr/bin/env python

from __future__ import print_function

import os
import shutil
import sys

class SectionLogger:
    """ A utility for creating log sections. """

    _is_first_section = True

    def __init__(self, header):
        self.header = header

    def log(self, *args):
        if self.header:
            if SectionLogger._is_first_section:
                SectionLogger._is_first_section = False
            else:
                print()
            print("-"*40)
            print(self.header)
            self.header = None
        print(*args)

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

def print_header(s):
    """ Prints a header section to stdout. """
    try:
        if print_header.called:
            print()
    except AttributeError:
        print_header.called = True
    print("-"*40)
    print(s)

def clean(paths):
    """ Cleans up broken symlinks in the provided directories. """
    logger = SectionLogger("Cleaning up dead symlinks...")
    for path in expanded_paths(paths):
        for item in sorted(os.listdir(path)):
            item = os.path.join(path, item)
            if os.path.islink(item) and not os.path.exists(item):
                logger.log("Removing symlink:", item)
                os.remove(item)

def backup(path, logger):
    """ If the path exists, backs it up. """
    dst = path + ".bak"
    logger.log("{} -> {}".format(path, dst))
    shutil.move(path, path + ".bak")

def link(paths):
    """ Symlinks the provided paths. """
    logger = SectionLogger("Setting up symlinks...")
    dotfile_dir = os.path.dirname(os.path.realpath(__file__))
    for src, dst in paths.iteritems():
        src = expand(os.path.join(dotfile_dir, src))
        dst = expand(dst)
        if os.path.exists(dst):
            if os.path.islink(dst):
                os.remove(dst)
            else:
                backup(logger, dst)
        logger.log("{} -> {}".format(src, dst))
        os.symlink(src, dst)

def create(paths):
    """ Creates the provided paths if they don't exist. """
    logger = SectionLogger("Creating directories...")
    for path in paths:
        path = expand(path)
        if not os.path.exists(path):
            logger.log("Creating:", path)
            os.makedirs(path)

def main(args):
    clean(["~", "~/.config"])
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
