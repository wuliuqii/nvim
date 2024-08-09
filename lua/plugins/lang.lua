local util = require("util")

return {
  {
    "williamboman/mason.nvim",
    enabled = util.uname() ~= "nixos",
  },

  {
    "williamboman/mason-lspconfig.nvim",
    enabled = util.uname() ~= "nixos",
  },
}
