vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

local cmp = require("cmp")
-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local ls = require("luasnip")
local lspkind = require("lspkind")

-- insert `(` after select function or method item
-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

cmp.setup({
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "copilot" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer", keyword_length = 4 },
    { name = "crates" },
  }),

  ---@diagnostic disable-next-line: missing-fields
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol",
      maxwidth = 30,
      ellipsis_char = "...",
      symbol_map = { Copilot = "" },
      -- https://github.com/hrsh7th/nvim-cmp/issues/1154
      menu = {},
      -- show_labelDetails = true,
    }),
  },

  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-y>"] = cmp.mapping(
      cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
      { "i", "c" }
    ),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
  }),

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
    { name = "cmdline" },
  }),
})

ls.config.set_config({
  history = false,
  updateevents = "TextChanged,TextChangedI",
  require("luasnip.loaders.from_vscode").lazy_load(),
  require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/" } }),
})

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })
