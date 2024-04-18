return {
  -- Toggleterm
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm" },
    keys = {
      {
        "<leader>ot",
        "<Cmd>ToggleTerm size=16 dir=%d direction=float<CR>",
        desc = "Toggle terminal",
      },
      { "<leader>ot", "<Cmd>ToggleTerm<CR>", mode = "t", desc = "Toggle terminal" },
    },
    opts = {},
  },

  -- Measure startup time
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- Session management. This saves your session in the background,
  -- keeping track of open buffers, window arrangement, and more.
  -- You can restore sessions when returning through the dashboard.
  {
    "folke/persistence.nvim",
    enabled = true,
    event = "BufReadPre",
    opts = { options = vim.opt.sessionoptions:get() },
    -- stylua: ignore
    keys = {
      { "<leader>ss", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>sl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>sd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },

  {
    "NStefan002/screenkey.nvim",
    cmd = "Screenkey",
    keys = { { "<leader>ok", "<Cmd>Screenkey<CR>", desc = "Toggle screenkey" } },
    config = true,
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>oz", "<Cmd>ZenMode<CR>", desc = "Zen Mode" },
    },
    config = true,
  },

  -- music player
  {
    "tamton-aquib/mpv.nvim",
    cmd = "MpvToggle",
    keys = {
      { "<leader>om", "<Cmd>MpvToggle<CR>", desc = "Toggle music player" },
    },
    config = true,
  },

  -- Library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },
}
