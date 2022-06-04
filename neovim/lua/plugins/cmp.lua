-- Configure completion.
local cmp = require("cmp");
local if_completion = function(f)
    return cmp.mapping(function(fallback)
        if cmp.visible() then f() else fallback() end
    end, {"i", "s"})
end

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = if_completion(cmp.confirm),
        ["<C-C>"] = if_completion(cmp.abort),
        ["<Tab>"] = if_completion(cmp.select_next_item),
        ["<S-Tab>"] = if_completion(cmp.select_prev_item),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
    }, {
        { name = "buffer" },
    })
})

cmp.setup.filetype({"gitcommit", "markdown", "text"}, {
    completion = { autocomplete = false }
})
