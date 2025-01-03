function leap_linewise(dir)
    local winid = vim.api.nvim_get_current_win()
    local wininfo = vim.fn.getwininfo(winid)[1]

    local step = 1
    if dir == "up" then step = -1 end

    -- Start far away from the cursor
    local lnum = vim.fn.line(".") + 3 * step
    local targets = {}
    while wininfo.topline <= lnum and lnum <= wininfo.botline do
        -- Always jump to the first non-empty character.
        -- Empty lines will be skipped
        local col = vim.fn.getline(lnum):find("%S")
        if col then table.insert(targets, { pos = { lnum, col } }) end
        lnum = lnum + step
    end

    require("leap").leap({
        target_windows = { winid },
        targets = targets,
        opts = { safe_labels = "" }, -- prevent autojump
    })
end

return {
    {
        "tpope/vim-repeat",
        config = function()
            -- Prevent this plugin from overwriting <C-R>
            vim.keymap.set("n", "<nop>", "<Plug>(RepeatRedo)")
        end,
    },
    {
        "ggandor/leap.nvim",
        dependencies = { "tpope/vim-repeat" },
        keys = {
            -- Default leap movments
            { "s", "<Plug>(leap-forward)", mode = { "n", "x", "o" } },
            { "S", "<Plug>(leap-backward)", mode = { "n", "x", "o" } },
            -- Linewise movement
            {
                "gj",
                function() leap_linewise("down") end,
                desc = "Leap down to line",
            },
            {
                "gk",
                function() leap_linewise("up") end,
                desc = "Leap up to line",
            },
        },
    },
    {
        "ggandor/flit.nvim",
        dependencies = { "ggandor/leap.nvim" },
        opts = {},
    },
}
