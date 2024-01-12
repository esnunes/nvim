return {
  "neovim/nvim-lspconfig",

  dependencies = {
    "folke/neodev.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
  },

  opts = nil,

  config = function()
    require("neodev").setup({})
    require("mason").setup()

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "gopls" },

      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,

        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
          })
        end,
      },
    })

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
      vim.lsp.handlers.hover,
      { border = 'rounded' }
    )

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      { border = 'rounded' }
    )
  end,
}
