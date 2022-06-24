-- Use line-style comments
vim.bo.commentstring = "// %s"

-- Fix an error with C++ highlighting where all CamelCase functions
-- are considered constructors.
vim.api.nvim_set_hl(0, "TSConstructor", { link="Function" })
