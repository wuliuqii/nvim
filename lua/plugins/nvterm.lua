return {
  "NvChad/nvterm",
  keys = {
    { "<leader>`", '<cmd>lua require("nvterm.terminal").toggle "horizontal"<cr>', desc = "Toggle Terminal" },
  },
  config = function()
    require("nvterm").setup({})

    vim.cmd([[ tnoremap <Esc> <C-\><C-n> ]])
  end,
}
