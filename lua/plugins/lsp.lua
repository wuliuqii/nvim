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
    "nvimdev/guard.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvimdev/guard-collection",
    },
    keys = { { "<leader>lf", "<cmd>GuardFmt<cr>", desc = "Guard format" } },
    config = function()
      local ft = require("guard.filetype")
      ft("rust"):fmt("rustfmt")
      ft("go"):fmt("gofmt"):append("golines"):lint({
        cmd = "golangci-lint",
        stdin = true,
      })
      ft("lua"):fmt("stylua")
      ft("zig"):fmt("zigfmt")
      ft("nix"):fmt({
        cmd = "nixpkgs-fmt",
        stdin = true,
      })
      ft("json"):fmt("prettier")
      ft("toml"):fmt("taplo")
      ft("markdown"):fmt("prettier")

      require("guard").setup({
        fmt_on_save = true,
        lsp_as_default_formatter = false,
      })
    end,
  },
}
