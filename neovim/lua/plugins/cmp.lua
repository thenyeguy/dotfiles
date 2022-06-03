-- Configure completion.
local cmp = require("cmp");
local if_completion = function(f)
    return cmp.mapping(function(fallback)
        if cmp.visible() then f() else fallback() end
    end, {"i", "s"})
end

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = if_completion(function() cmp.confirm({ select = true }) end),
        ["<Esc>"] = if_completion(cmp.abort),
        ["<Tab>"] = if_completion(cmp.select_next_item),
        ["<S-Tab>"] = if_completion(cmp.select_prev_item),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
    }, {
        { name = "buffer" },
    })
})
