return {
  -- LSP config
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "folke/neodev.nvim",
        opts = {},
      },
      {
        "folke/neoconf.nvim",
        cmd = "Neoconf",
        opts = {},
        dependencies = { "nvim-lspconfig" },
      },
    },
    config = require("config.lsp"),
  },

  -- Navbuddy
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    event = "LspAttach",
    config = function()
      local navbuddy = require("nvim-navbuddy")
      local actions = require("nvim-navbuddy.actions")

      navbuddy.setup({
        window = {
          border = "rounded", -- "rounded", "double", "solid", "none"
        },
        mappings = {
          ["<S-Tab>"] = actions.parent(), -- Move to left panel
          ["<Tab>"] = actions.children(), -- Move to right panel
          ["<Left>"] = actions.parent(), -- Move to left panel
          ["<Right>"] = actions.children(), -- Move to right panel
        },
        lsp = { auto_attach = true },
      })

      vim.keymap.set("n", "<leader>ln", "<Cmd>Navbuddy<CR>", { desc = "Open Navbuddy" })
    end,
  },

  -- lsp signature
  {
    "ray-x/lsp_signature.nvim",
    event = "LspAttach",
    config = function()
      require("lsp_signature").setup({
        bind = true,
        handler_opts = {
          border = "rounded",
        },
      })
    end,
  },

  -- format
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>lf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt" },
        toml = { "taplo" },
        go = { "gofmt", "golines" },
        nix = { "nixpkgs_fmt" },
        zig = { "zigfmt" },
        markdown = { "prettier" },
        json = { "prettier" },
      },
      -- Set up format-on-save
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
  },
}
