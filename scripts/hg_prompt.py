#!/usr/bin/env python
# coding: utf-8

from mercurial import cmdutil

cmdtable = {}
command = cmdutil.command(cmdtable)

# `revrange` has been moved into module `scmutil` since v1.9.
try:
  from mercurial import scmutil
  revrange = scmutil.revrange
except:
  revrange = cmdutil.revrange

PROMPT_DIRTY_CHAR = "○"
PROMPT_ADDED_CHAR = "◉"


@command("prompt", [], "hg prompt")
def prompt(ui, repo, fs="", **opts):
  components = []

  working = repo["."]
  if working.branch() != "default":
    components.append(working.branch())
  components.extend(working.bookmarks())
  components.extend(tag for tag in working.tags() if tag != "tip")
  components.append("({})".format(working.rev()))

  status = repo.status(unknown=True)
  status_chars = ""
  if status.modified or status.deleted:
    status_chars += PROMPT_DIRTY_CHAR
  if status.added:
    status_chars += PROMPT_ADDED_CHAR
  if status_chars:
    components.append(status_chars)

  ui.status(" ".join(components))

  # Return dirty state via status
  if status.modified or status.deleted or status.added or status.unknown:
    return 1
  else:
    return 0
