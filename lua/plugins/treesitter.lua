return {
  "nvim-treesitter/nvim-treesitter",

  build = ":TSUpdate",

  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "javascript", "css", "html",
        "go", "gomod",
        "c", "cmake",
        "lua",
        "vim", "vimdoc",
        "yaml",
        "query",
        "bash",
        "dockerfile",
        "make",
        "rust",
        "ruby",
        "swift",
        "terraform",
        "templ",
        "zig",
        "ledger",
      },
      ignore_install = {},

      modules = {},

      sync_install = false,
      auto_install = true,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    })
  end,
}
