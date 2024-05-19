return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "stevearc/conform.nvim",
      "b0o/SchemaStore.nvim",
      "j-hui/fidget.nvim",
    },
    config = function()
      require("plugins.config.lsp")
    end,
  },
}
