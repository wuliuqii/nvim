return {
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "catppuccin" },
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      -- transparent_background = true,
      flavour = "auto",
      background = { -- :h background
        light = "latte",
        dark = "macchiato",
      },
      integrations = {
        blink_cmp = true,
        fzf = true,
        snacks = true,
      },
      term_colors = true,
    },
  },
}
