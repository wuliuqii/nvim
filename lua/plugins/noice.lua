return {
  "folke/noice.nvim",
  opts = {
    format = {
      spinner = {
        name = "moon",
      },
      lsp_progress = {
        -- {
        --   "{progress} ",
        --   key = "progress.percentage",
        --   contents = {
        --     { "{data.progress.message} " },
        --   },
        -- },
        "({data.progress.percentage}%) ",
        { "{spinner} ", hl_group = "NoiceLspProgressSpinner" },
        { "{data.progress.title} ", hl_group = "NoiceLspProgressTitle" },
        { "{data.progress.client} ", hl_group = "NoiceLspProgressClient" },
      },
    },
  },
}
