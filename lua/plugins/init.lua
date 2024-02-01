COLORSCHEME = "catppuccin-macchiato"

require("lazy").setup({
  require("plugins.editor"),
  require("plugins.themes"),
  require("plugins.tools"),
  require("plugins.ui"),
  require("plugins.coding"),
  require("plugins.treesitter"),
  require("plugins.lsp"),
  require("plugins.lang"),
})

vim.cmd.colorscheme(COLORSCHEME)
