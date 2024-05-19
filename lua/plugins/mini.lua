return {
  {
    "echasnovski/mini.nvim",
    event = "BufReadPre",
    config = function()
      require("mini.ai").setup()
      require("mini.surround").setup()
      require("mini.indentscope").setup()
    end,
  },
}
