local util = require("util")

return {
  {
    "mason-org/mason.nvim",
    enabled = util.uname() ~= "nixos",
  },

  {
    "mason-org/mason-lspconfig.nvim",
    enabled = util.uname() ~= "nixos",
  },
}
