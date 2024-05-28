local util = require("util")

return {
  {
    "williamboman/mason.nvim",
    enabled = util.uname() ~= "nixos",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "nix",
        "zig",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nil_ls = {},
        zls = {},
      },
    },
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "lawrence-laz/neotest-zig",
    },
    opts = {
      adapters = {
        ["neotest-zig"] = {},
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        nix = { "nixpkgs_fmt" },
        zig = { "zigfmt" },
      },
    },
  },
}
