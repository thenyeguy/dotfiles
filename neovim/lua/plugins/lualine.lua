return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "arkav/lualine-lsp-progress",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        options = { globalstatus = true },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { { "filename", path = 1 } },
            lualine_c = {},
            lualine_x = {
                {
                    "lsp_progress",
                    display_components = { "spinner", "lsp_client_name" },
                    separators = { lsp_client_name = { pre = "", post = "" } },
                    -- stylua: ignore
                    spinner_symbols = { "⠂", "⠒", "⠐", "⠰", "⠠", "⠤", "⠄", "⠆" },
                },
                {
                    "diagnostics",
                    sections = { "error", "warn", "info" },
                },
            },
            lualine_y = { "location" },
            lualine_z = {},
        },
    },
}
