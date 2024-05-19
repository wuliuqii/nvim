return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "vim",
        "vimdoc",
        "json",
        "xml",
        "just",
        "norg",
        "nix",
        "zig",

        "go",
        "gomod",
        "gowork",
        "gosum",

        "rust",
        "toml",

        "typescript",
        "tsx",
      },
    },
  },
}
