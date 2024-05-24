local function uname()
  local handle = io.popen("uname")
  if handle then
    local res = handle:read("a")
    handle:close()
    return string.match(res, "^%s*(.-)%s*$")
  end
  return nil
end

return {
  {
    "williamboman/mason.nvim",
    enabled = uname() == "Nixos",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "nix",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nil_ls = {},
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        nix = { "nixpkgs_fmt" },
      },
    },
  },
}
