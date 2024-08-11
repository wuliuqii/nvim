return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
      { "<leader>-", "require('oil').toggle_float", desc = "Oil Toggle" },
    },
    opts = {
      columns = { "icon" },
      view_options = {
        show_hidden = true,
      },
    },
  },
}
