-- sets
vim.g.mapleader = " "

vim.opt.clipboard = 'unnamedplus'

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.autoread = true

vim.opt.colorcolumn = "120"
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.termguicolors = true

-- lazy plugin manager
do
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)
end

require("lazy").setup({
  spec = "plugins",
  change_detection = { notify = false },
})

-- remaps
vim.keymap.set({ "n", "v" }, "<C-c>", "<Esc>")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local wk = require("which-key")

    wk.register({
      K = { vim.lsp.buf.hover, "hover" },

      ["<leader>"] = {
        l = {
          name = "lsp",
          a = { vim.lsp.buf.code_action, "actions" },
          d = { vim.lsp.buf.definition, "definition" },
          D = { vim.lsp.buf.declaration, "declaration" },
          f = {
            name = "symbols",
            d = { "<cmd>Telescope lsp_document_symbols<cr>", "document" },
            w = { "<cmd>Telescope lsp_workspace_symbols<cr>", "workspace" },
          },
          i = { "<cmd>Telescope lsp_implementations<cr>", "implementations" },
          r = { "<cmd>Telescope lsp_references<cr>", "references" },
          R = { vim.lsp.buf.rename, "rename" },
          s = {
            name = "server",
            r = { "<cmd>LspRestart<cr>", "restart" },
            i = { "<cmd>LspInfo<cr>", "info" },
          },
          ["="] = { vim.lsp.buf.format, "format" },
        },
      },
    }, { buffer = ev.buf })
  end,
})

do
  local wk = require("which-key")
  wk.register({
    ["<leader>"] = {
      p = {
        name = "project",
        c = { vim.cmd.Ex, "current folder" },
        f = { "<cmd>Telescope find_files<cr>", "find files" },
        g = { "<cmd>Telescope git_files<cr>", "git files" },
        s = { "<cmd>Telescope live_grep<cr>", "search files" },
      },
      b = {
        name = "buffer",
        f = { "<cmd>Telescope buffers<cr>", "find buffer" },
        d = { vim.cmd.bdelete, "delete" },
      },
      g = { vim.cmd.Git, "git" },
      u = { "<cmd>UndotreeToggle<cr>", "undo tree" },
      c = { "<cmd>Telescope commands<cr>", "commands" },
      h = {
        name = "help",
        t = { "<cmd>Telescope help_tags<cr>", "tags" },
        k = { "<cmd>Telescope keymaps<cr>", "keymaps" },
      },
      t = {
        name = "trouble",
        t = { "<cmd>TroubleToggle<cr>", "toggle" },
        w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace diagnostics" },
        d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document diagnostics" },
        q = { "<cmd>TroubleToggle quickfix<cr>", "quick fix" },
        l = { "<cmd>TroubleToggle loclist<cr>", "location list" },
      },
    },
  })
end

-- ui
-- vim.diagnostic.config({
--  virtual_text = false,
--  severity_sort = true,
--  float = {
--    border = 'rounded',
--    source = 'always',
--  },
--})
