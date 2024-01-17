-- OCaml style is 2 spaces per indent.
vim.o.shiftwidth = 2
vim.o.tabstop = 2

-- Prevent autopairs from handling single quotes (e.g. for type variables).
vim.keymap.set("i", "'", "'", { remap = false })
