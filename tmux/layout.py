#!/usr/bin/env python3

import argparse
import enum
import os
import re
import subprocess
import sys

PREFERRED_WIDTHS = {"kak": 90}
MIN_WIDTH = 100

LAYOUT_RE = re.compile(r"\[layout (?P<layout>.*)\] .* \(active\)$")
NODE_RE = re.compile(
    r"^(?P<width>\d+)x(?P<height>\d+),\d+,\d+((,(?P<pane>\d+),?(?P<rest>.*))"
    r"|((?P<cols>{.*))|(?P<rows>\[.*?))$"
)


def split_node(node):
    open = node[0]
    if open == "{":
        close = "}"
    elif open == "[":
        close = "]"
    levels = 0
    for i in range(len(node)):
        if node[i] == open:
            levels += 1
        elif node[i] == close:
            levels -= 1
        if levels == 0:
            return (node[1:i], node[i + 2 :])
    raise ValueError("Couldn't split node")


def parse_layout(layout, panes):
    nodes = []
    while layout:
        node = None
        match = NODE_RE.match(layout)
        if match:
            width = int(match.group("width"))
            height = int(match.group("height"))
            if match.group("pane"):
                node = panes[match.group("pane")]
                node.width = width
                node.height = height
                layout = match.group("rest")
            elif match.group("cols"):
                cols, layout = split_node(match.group("cols"))
                cols = parse_layout(cols, panes)
                node = Columns(width, height, cols)
                for col in cols:
                    col.parent = node
            elif match.group("rows"):
                rows, layout = split_node(match.group("rows"))
                rows = parse_layout(rows, panes)
                node = Rows(width, height, rows)
                for row in rows:
                    row.parent = node
        if node:
            nodes.append(node)
        else:
            raise ValueError("couldn't parse layout: {}".format(layout))
    return nodes


def call(cmd):
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE)
    for line in proc.stdout:
        yield line.decode("utf-8").strip()


class Orientation(enum.Enum):
    horizontal = "horizontal"
    vertical = "vertical"


class Direction(object):
    def __init__(self, orientation, before):
        self.orientation = orientation
        self.before = before

    def flags(self):
        if self.orientation == Orientation.horizontal:
            flags = ["-h"]
        else:
            flags = ["-v"]
        if self.before:
            flags.append("-b")
        return flags

    def __str__(self):
        return "Direction({}, {})".format(
            self.orientation, "before" if self.before else "after"
        )


class Node(object):
    def preferred_width(self):
        return None

    def preferred_orientation(self, direction):
        raise NotImplementedError

    def resize(self, width, height):
        raise NotImplementedError

    def debug_string(self, indent=""):
        raise NotImplementedError


class Pane(Node):
    def __init__(self, id, job, active):
        self.id = id
        self.job = job
        self.active = active == "1"
        self.width = None
        self.height = None
        self.parent = None

    def preferred_width(self):
        return PREFERRED_WIDTHS.get(self.job)

    def preferred_orientation(self):
        if self.width < 2 * MIN_WIDTH:
            return Orientation.vertical
        else:
            return Orientation.horizontal

    def resize(self, width, height):
        if abs(width - self.width) <= 1 and abs(height - self.height) <= 1:
            # Prevent flickering due to rounding errors. Any pane within one
            # pixel of its target size is Good Enough.
            return
        subprocess.call(
            ["tmux", "resize-pane", "-t", self.id, "-x", str(width), "-y", str(height)]
        )

    def split(self, direction, cmd=[]):
        subprocess.call(
            ["tmux", "split-window", "-t", self.id, "-c", "#{pane_current_path}"]
            + direction.flags()
            + cmd
        )

    def debug_string(self, indent=""):
        return indent + str(self)

    def __str__(self):
        return "Pane({}, {}, {}x{}{})".format(
            self.id,
            self.job,
            self.width,
            self.height,
            ", active" if self.active else "",
        )


class Columns(Node):
    def __init__(self, width, height, columns):
        self.width = width
        self.height = height
        self.columns = columns

    def preferred_orientation(self):
        # Compute fixed widths, and remaining shares with new column:
        shares = len(self.columns) + 1
        shared_width = self.width - len(self.columns) + 2
        for col in self.columns:
            if col.preferred_width():
                shares -= 1
                shared_width -= col.preferred_width()
        share = shared_width // shares if shares else 0

        if share < MIN_WIDTH:
            return Orientation.vertical
        else:
            return Orientation.horizontal

    def resize(self, width, height):
        # Remove the borders from the total width:
        width = width - len(self.columns) + 1

        # Compute preferred widths, then divide the remaining width between the
        # rest of the columns. The last column does not get to prefer a width.
        shares = len(self.columns)
        shared_width = width
        for col in self.columns[:-1]:
            if col.preferred_width():
                shares -= 1
                shared_width -= col.preferred_width()
        share = shared_width // shares

        remaining = width
        for col in self.columns[:-1]:
            col_width = col.preferred_width() or share
            col.resize(col_width, height)
            remaining -= col_width
        self.columns[-1].resize(remaining, height)

    def debug_string(self, indent=""):
        cols = "\n".join(col.debug_string(indent + "  ") for col in self.columns)
        return "{}{}:\n".format(indent, self) + cols

    def __str__(self):
        return "Columns({}x{})".format(self.width, self.height)


class Rows(Node):
    def __init__(self, width, height, rows):
        self.width = width
        self.height = height
        self.rows = rows

    def preferred_width(self):
        width = None
        for row in self.rows:
            row_width = row.preferred_width()
            if row_width and (width is None or width < row_width):
                width = row_width
        return width

    def preferred_orientation(self):
        return Orientation.vertical

    def resize(self, width, height):
        share = (height - len(self.rows) + 1) // len(self.rows)
        for row in self.rows:
            row.resize(width, share)

    def debug_string(self, indent=""):
        rows = "\n".join(row.debug_string(indent + "  ") for row in self.rows)
        return "{}{}:\n".format(indent, self) + rows

    def __str__(self):
        return "Rows({}x{})".format(self.width, self.height)


class Layout(object):
    def __init__(self, panes, top):
        self.panes = panes
        self.top = top

    @classmethod
    def load(cls):
        panes = dict()
        for line in call(
            [
                "tmux",
                "list-panes",
                "-F",
                "#{pane_id} #{pane_current_command} #{pane_active}",
            ]
        ):
            pane = Pane(*line.split(" "))
            panes[pane.id[1:]] = pane

        for line in call(["tmux", "list-windows"]):
            match = LAYOUT_RE.search(line)
            if match:
                layout = match.group("layout").split(",", 1)[1]
                nodes = parse_layout(layout, panes)
                if len(nodes) == 1:
                    return cls(panes, nodes[0])

        raise ValueError("Couldn't find window layout")


def show(args):
    layout = Layout.load()
    print(layout.top.debug_string())


def resize(args):
    layout = Layout.load()
    layout.top.resize(layout.top.width, layout.top.height)


def split(args):
    layout = Layout.load()

    if not args.pane:
        for pane in layout.panes.values():
            if pane.active:
                args.pane = pane.id
                break
    pane = layout.panes[args.pane.replace("%", "")]

    if args.vertical:
        direction = Direction(Orientation.vertical, args.before)
    elif args.horizontal:
        direction = Direction(Orientation.horizontal, args.before)
    else:
        node = pane.parent or pane
        direction = Direction(node.preferred_orientation(), args.before)

    pane.split(direction, args.cmd)


parser = argparse.ArgumentParser()
subparsers = parser.add_subparsers()

parser_show = subparsers.add_parser("show")
parser_show.set_defaults(func=show)

parser_resize = subparsers.add_parser("resize")
parser_resize.set_defaults(func=resize)

parser_split = subparsers.add_parser("split", add_help=False)
parser_split.add_argument("--pane", "-p", type=str)
parser_split_dir = parser_split.add_mutually_exclusive_group()
parser_split_dir.add_argument("--vertical", "-v", action="store_true")
parser_split_dir.add_argument("--horizontal", "-h", action="store_true")
parser_split.add_argument("--before", "-b", action="store_true")
parser_split.add_argument("cmd", nargs="*")
parser_split.set_defaults(func=split)

if __name__ == "__main__":
    if "TMUX" not in os.environ:
        print("Error: must be run from inside tmux", file=sys.stderr)
        sys.exit(1)

    args = parser.parse_args()
    args.func(args)
