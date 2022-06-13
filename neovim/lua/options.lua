-- Editor displays
vim.o.cursorline = true
vim.o.number = true
vim.o.showmode = false
vim.o.signcolumn = "number"

-- Editor behavior
vim.o.mouse = "a"
vim.o.scrolloff = 5
vim.o.showmatch = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.undofile = true

vim.o.list = true
vim.o.listchars = "tab:»-,trail:·"

-- Editor formatting
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

vim.o.breakindent = true
vim.o.linebreak = true
vim.o.showbreak = "»-"

-- Search/replace settings.
vim.o.gdefault = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Spellcheck
vim.api.nvim_create_autocmd({"Filetype"}, {
    pattern = {"gitcommit", "hgcommit", "markdown"},
    command = "setlocal spell",
})

-- Line-wrapping
vim.api.nvim_create_autocmd({"Filetype"}, {
    pattern = {"hgcommit", "markdown", "text"},
    command = "setlocal textwidth=80",
})
