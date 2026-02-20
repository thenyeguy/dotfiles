local function set_clipboard(s)
    vim.fn.setreg("+", s)
    print("Copied: " .. s)
end

function yank_directory_path()
    local path = vim.fn.expand("%:.:h")
    set_clipboard(path)
end

function yank_file_path()
    local path = vim.fn.expand("%:.")
    set_clipboard(path)
end

function yank_file_path_and_line()
    local path = vim.fn.expand("%:.")

    local line
    if vim.api.nvim_get_mode().mode:find("[vV]") then
        -- Exit visual mode to update the '< and '> marks
        vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
            "x",
            true
        )
        local start_line = vim.fn.line("'<")
        local end_line = vim.fn.line("'>")
        if start_line == end_line then
            line = start_line
        else
            line = start_line .. "-" .. end_line
        end
    else
        line = vim.fn.line(".")
    end

    local result = path .. ":" .. line
    vim.fn.setreg("+", result)
    print("Copied: " .. result)
end

vim.keymap.set("", "<leader>yd", yank_directory_path, { desc = "Yank directory path" })
vim.keymap.set("", "<leader>yf", yank_file_path, { desc = "Yank filename" })
vim.keymap.set(
    "",
    "<leader>yl",
    yank_file_path_and_line,
    { desc = "Yank file path (with line numbers)" }
)
