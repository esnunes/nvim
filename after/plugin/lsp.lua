local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
    'gopls',
    'rust_analyzer',
    'lua_ls',
})

lsp.on_attach(function(client, bufnr)
    local function opts(desc)
        return { buffer = bufnr, remap = false, desc = desc }
    end

    vim.keymap.set("n", "gR", function() vim.lsp.buf.rename() end, opts("lsp: rename"))
    vim.keymap.set("n", "ga", function() vim.lsp.buf.code_action() end, opts("lsp: code actions"))
    vim.keymap.set("n", "g=", function() vim.lsp.buf.format({ async = true }) end, opts("lsp: format"))
end)

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
