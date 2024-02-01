return function()
  local neotest_ns = vim.api.nvim_create_namespace("neotest")
  vim.diagnostic.config({
    virtual_text = {
      format = function(diagnostic)
        -- Replace newline and tab characters with space for more compact diagnostics
        local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
        return message
      end,
    },
  }, neotest_ns)

  require("neotest").setup({
    adapters = {
      require("neotest-go"),
      require("neotest-rust"),
    },
    status = { virtual_text = true },
    output = { open_on_run = true },
    quickfix = {
      open = function()
        require("trouble").open({ mode = "quickfix", focus = false })
      end,
    },
  })
end
