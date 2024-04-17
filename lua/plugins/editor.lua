return {
  -- Neo-tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      { "<leader>oe", "<cmd>Neotree toggle<cr>", desc = "Explorer NeoTree" },
    },
    opts = {
      window = {
        width = 30,
        auto_expand_width = true,
      },
    },
  },

  -- file explore
  {
    "stevearc/oil.nvim",
    cmd = { "Oil" },
    opts = {},
    keys = {
      { "<leader>od", "<cmd>Oil<cr>", desc = "Explorer Oil" },
    },
  },

  -- Search/Replace
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    keys = {
      {
        "<leader>sr",
        function()
          require("spectre").open()
        end,
        desc = "Replace in files (Spectre)",
      },
    },
  },

  -- Better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      height = 15,
      action_keys = {
        jump = { "o", "<tab>" },
        jump_close = { "<cr>" },
      },
      use_diagnostic_signs = true,
    },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Trouble" },
      { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Trouble workspace" },
      { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Trouble document" },
      { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Trouble loclist" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Trouble quickfix" },
      { "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>", desc = "Trouble lsp_references" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    -- cmd = "Telescope",
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-telescope/telescope-project.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = require("config.telescope"),
  },

  -- Flash, quickly jump to s specific location.
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },

  -- Flash Telescope config
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = function(_, opts)
      local function flash(prompt_bufnr)
        require("flash").jump({
          pattern = "^",
          label = { after = { 0, 0 } },
          search = {
            mode = "search",
            exclude = {
              function(win)
                return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
              end,
            },
          },
          action = function(match)
            local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            picker:set_selection(match.pos[1] - 1)
          end,
        })
      end
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        mappings = {
          n = { s = flash },
          i = { ["<c-s>"] = flash },
        },
      })
    end,
  },

  -- Which Key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>f"] = { name = "+find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>c"] = { name = "+code/copilot" },
        ["<leader>h"] = { name = "+help" },
        ["<leader>l"] = { name = "+lsp" },
        ["<leader>n"] = { name = "+noice" },
        ["<leader>o"] = { name = "+open" },
        ["<leader>p"] = { name = "+project" },
        ["<leader>s"] = { name = "+search/select/session" },
        ["<leader>t"] = { name = "+tab/test" },
        ["<leader>w"] = { name = "+window" },
        ["<leader>x"] = { name = "+diagnostics" },
        ["<leader><TAB>"] = { name = "+tab" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts, _)
      wk.register(opts.defaults)
    end,
  },

  -- Diffview
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = true,
    keys = {
      { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "DiffView Open" },
      { "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "DiffView Close" },
      { "<leader>gdf", "<cmd>DiffviewClose<cr>", desc = "DiffView Toggle Files" },
    },
  },

  -- Neogit
  {
    "NeogitOrg/neogit",
    cmd = { "Neogit" },
    config = true,
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
    },
  },

  -- Buffer remove
  {
    "echasnovski/mini.bufremove",
    -- stylua: ignore
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },

  -- Move
  {
    "fedepujol/move.nvim",
    event = "BufEnter",
    keys = {
      { "<M-Down>", "<Cmd>MoveLine(1)<CR>", desc = "Move line up" },
      { "<M-Up>", "<Cmd>MoveLine(-1)<CR>", desc = "Move line down" },
      { "<M-Left>", "<Cmd>MoveWord(-1)<CR>}", desc = "Move word left" },
      { "<M-Right>", "<Cmd>MoveWord(1)<CR>}", desc = "Move word right" },

      -- Visual-mode commands
      { "<M-Up>", "<Cmd>MoveBlock(-1)<CR>", mode = "v", desc = "Move block up" },
      { "<M-Down>", "<Cmd>MoveBlock(1)<CR>", mode = "v", desc = "Move block down" },
      { "<M-Left>", "<Cmd>MoveHBlock(-1)<CR>", mode = "v", desc = "Move block left" },
      { "<M-Right>", "<Cmd>MoveHBlock(1)<CR>", mode = "v", desc = "Move block right" },
    },
  },

  -- nvim-ufo
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    event = "BufReadPost",
    config = function()
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" 󰁂 %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end

      -- global handler
      -- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
      -- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.
      require("ufo").setup({
        fold_virt_text_handler = handler,

        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      })
    end,
  },

  -- undo tree
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>ou", "<cmd>UndotreeToggle<cr>", desc = "Undo Tree" },
    },
  },
}
