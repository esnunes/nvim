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
      ensure_installed = { "lua_ls", "gopls", "templ", "terraformls" },

      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,

        ["terraformls"] = function()
          require("lspconfig").terraformls.setup({
            capabilities = capabilities,
          })
          vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            pattern = { "*.tf", "*.tfvars" },
            callback = function()
              vim.lsp.buf.format()
            end,
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

        ["gopls"] = function()
          local opts = { capabilities = capabilities }

          -- use local version of gopls if possible
          local cmd_path = vim.loop.fs_realpath(vim.fn.getcwd() .. "/.bin/gopls")
          if cmd_path ~= nil and vim.fn.filereadable(cmd_path) then
            opts.cmd = { cmd_path }
          end

          require("lspconfig").gopls.setup(opts)
        end,

        ["templ"] = function()
          local opts = { capabilities = capabilities }

          -- use local version of templ lsp if possible
          local cmd_path = vim.loop.fs_realpath(vim.fn.getcwd() .. "/.bin/templ")
          if cmd_path ~= nil and vim.fn.filereadable(cmd_path) then
            opts.cmd = { cmd_path, "lsp" }
          end

          require("lspconfig").templ.setup(opts)
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
