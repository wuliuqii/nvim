return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "onsails/lspkind.nvim",
      "saadparwaiz1/cmp_luasnip",
      "Saecki/crates.nvim",
      {
        "L3MON4D3/LuaSnip",
        version = "2.*",
        dependencies = "rafamadriz/friendly-snippets",
      },
    },
    version = false, -- last release is way too old
    event = "InsertEnter",
    config = function()
      require("plugins.config.completion")
    end,
  },
}
