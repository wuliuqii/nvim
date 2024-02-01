return {
  -- Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        dim_inactive = {
          enabled = true, -- dims the background color of inactive window
          shade = "dark",
          percentage = 0.45, -- percentage of the shade to apply to the inactive window
        },
        integrations = {
          cmp = true,
          dap = {
            enabled = true,
            enable_ui = true, -- enable nvim-dap-ui
          },
          flash = true,
          gitsigns = true,
          indent_blankline = {
            enabled = true,
            scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
            colored_indent_levels = false,
          },
          lsp_trouble = true,
          markdown = true,
          mason = true,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
            inlay_hints = {
              background = true,
            },
          },
          neotest = true,
          noice = true,
          notify = true,
          octo = true,
          overseer = true,
          semantic_tokens = true,
          telescope = {
            enabled = true,
          },
          treesitter = true,
          ts_rainbow2 = true,
          ufo = true,
          which_key = true,
        },
      })
    end,
  },

  -- Material
  {
    "marko-cerovac/material.nvim",
    lazy = true,
    config = function()
      require("material").setup({
        plugins = { -- Uncomment the plugins that you use to highlight them
          -- Available plugins:
          "dap",
          "dashboard",
          "gitsigns",
          "hop",
          "indent-blankline",
          "lspsaga",
          "mini",
          "neogit",
          "neorg",
          "nvim-cmp",
          "nvim-navic",
          "nvim-tree",
          "nvim-web-devicons",
          "sneak",
          "telescope",
          "trouble",
          "which-key",
        },
      })

      vim.api.nvim_create_user_command("MaterialSelect", require("material.functions").find_style, {})
    end,
  },

  -- One Dark
  {
    "olimorris/onedarkpro.nvim",
    lazy = true,
  },

  -- Monokai Pro
  {
    "loctvl842/monokai-pro.nvim",
    lazy = true,
  },

  -- Dracula
  {
    "Mofiqul/dracula.nvim",
    lazy = true,
  },

  -- Adwaita
  {
    "Mofiqul/adwaita.nvim",
    lazy = true,
  },

  -- VSCode (Dark+ and Light+)
  {
    "Mofiqul/vscode.nvim",
    lazy = true,
  },

  -- Nord
  {
    "shaunsingh/nord.nvim",
    lazy = true,
  },

  -- Tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = true,
  },

  -- Oxacarbon
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = true,
  },

  -- GitHub Nvim Theme
  {
    "projekt0n/github-nvim-theme",
    lazy = true,
  },

  -- Nightfox
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
  },

  -- Rosé Pine
  {
    "rose-pine/neovim",
    lazy = true,
  },

  -- Solarized
  {
    "maxmx03/solarized.nvim",
    lazy = true,
  },
}
