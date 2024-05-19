return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = { 
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>oe", "<cmd>Neotree toggle<cr>", desc = "Explorer NeoTree" },
    },
    opts = {
      window = {
        width = 30,
        auto_expand_width = true,
      },
    },
  },
}
