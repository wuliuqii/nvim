return {
  {
    "m4xshen/hardtime.nvim",
    event = "BufReadPre",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
      disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil", "dashboard" },
    },
    keys = {
      { "n", "j", "<cmd>Hardtime<cr>", desc = "Hardtime" },
      { "n", "k", "<cmd>Hardtime<cr>", desc = "Hardtime" },
      { "n", "gj", "<cmd>Hardtime<cr>", desc = "Hardtime" },
      { "n", "gk", "<cmd>Hardtime<cr>", desc = "Hardtime" },
    },
  },
}
