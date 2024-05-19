if true then
  return {}
end

return {
  {
    "lukas-reineke/headlines.nvim",
    opts = function()
      local opts = {}
      for _, ft in ipairs({ "markdown", "norg", "rmd", "org" }) do
        opts[ft] = {
          headline_highlights = {},
        }
        for i = 1, 6 do
          local hl = "Headline" .. i
          vim.api.nvim_set_hl(0, hl, { link = "Headline", default = true })
          table.insert(opts[ft].headline_highlights, hl)
        end
      end
      return opts
    end,
    ft = { "markdown", "norg", "rmd", "org" },
    config = function(_, opts)
      -- PERF: schedule to prevent headlines slowing down opening a file
      vim.schedule(function()
        require("headlines").setup(opts)
        require("headlines").refresh()
      end)
    end,
  },

  -- LSP diagnostics in virtual text at the top right of your screen
  {
    "dgagn/diagflow.nvim",
    enabled = false,
    event = "LspAttach",
    opts = {},
  },

  {
    "tamton-aquib/duck.nvim",
    -- stylua: ignore
    keys = {
      {
        "<leader>op",
        function()
          require("duck").hatch("🐈", 10)
        end,
        desc = "Hatch Duck",
      },
      {
        "<leader>kp",
        function()
          require("duck").cook()
        end,
        desc = "Cook Duck",
      },
      {
        "<leader>ka",
        function()
          require("duck").cook_all()
        end,
        desc = "Cook All Ducks",
      },
    },
  },

  {
    "nvim-neorg/neorg",
    cmd = { "Neorg" },
    ft = { "norg" },
    dependencies = {
      { "nvim-neorg/neorg-telescope" },
    },
    keys = {
      { "<leader>oo", "<cmd>Neorg workspace notes<cr>", desc = "Neorg workspace" },
    },
    build = ":Neorg sync-parsers",
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.autocommands"] = {},
        -- ["core.esupports.metagen"] = {
        -- 	config = {
        -- 		type = "auto",
        -- 	},
        -- },
        ["core.concealer"] = {
          config = {
            icon_preset = "varied",
            folds = true,
          },
        },
        ["core.export"] = {},
        ["core.export.markdown"] = {
          config = {
            extensions = { "all" },
          },
        },
        ["core.completion"] = {
          config = { engine = "nvim-cmp" },
        },
        ["core.integrations.nvim-cmp"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/orgs/notes",
            },
            default_workspace = "notes",
          },
        },
        ["core.integrations.telescope"] = {},
        ["core.integrations.treesitter"] = {},
      },
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },

  -- typst
  {
    "chomosuke/typst-preview.nvim",
    dev = false,
    ft = "typst",
    opts = {
      dependencies_bin = {
        ["typst-preview"] = "typst-preview",
        ["websocat"] = "websocat",
      },
      invert_colors = "auto",
      debug = false,
      open_cmd = "firefox %s --target window ",
    },
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = { "rust" },
    opts = {
      server = {
        on_attach = function(client, bufnr)
          local wk = require("which-key")
          wk.register({
            ["<leader>cA"] = {
              function()
                vim.cmd.RustLsp("codeAction")
              end,
              "Code Action",
            },
            ["<leader>dr"] = {
              function()
                vim.cmd.RustLsp("debuggables")
              end,
              "Rust debuggables",
            },
          }, { mode = "n", buffer = bufnr })
        end,

        settings = {
          ["rust-analyzer"] = {
            imports = {
              granularity = {
                group = "module",
              },
              prefix = "self",
            },
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            },
            -- checkOnSave = false,
            check = {
              command = "clippy",
              allTargets = false,
              extraArgs = {
                "--no-deps",
              },
              allFeatures = false,
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
          },
        },
      },
    },

    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("force", {}, opts or {})
    end,
  },

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

  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    event = "LspAttach",
    config = function()
      local navbuddy = require("nvim-navbuddy")
      local actions = require("nvim-navbuddy.actions")

      navbuddy.setup({
        window = {
          border = "rounded", -- "rounded", "double", "solid", "none"
        },
        mappings = {
          ["<S-Tab>"] = actions.parent(), -- Move to left panel
          ["<Tab>"] = actions.children(), -- Move to right panel
          ["<Left>"] = actions.parent(), -- Move to left panel
          ["<Right>"] = actions.children(), -- Move to right panel
        },
        lsp = { auto_attach = true },
      })

      vim.keymap.set("n", "<leader>ln", "<Cmd>Navbuddy<CR>", { desc = "Open Navbuddy" })
    end,
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "LspAttach",
    config = function()
      require("lsp_signature").setup({
        bind = true,
        handler_opts = {
          border = "rounded",
        },
      })
    end,
  },

  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        progress = {
          enabled = false,
        },
        signature = {
          enabled = false,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
      messages = {
        enabled = true,
      },
    },
    -- stylua: ignore
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    },
  },

  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function()
      -- don't use animate when scrolling with the mouse
      local mouse_scrolled = false
      for _, scroll in ipairs({ "Up", "Down" }) do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set({ "", "i" }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      local animate = require("mini.animate")
      return {
        resize = {
          timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
        },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
          subscroll = animate.gen_subscroll.equal({
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          }),
        },
      }
    end,
  },

  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },

  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>oz", "<Cmd>ZenMode<CR>", desc = "Zen Mode" },
    },
    config = true,
  },

  {
    "NStefan002/screenkey.nvim",
    cmd = "Screenkey",
    keys = { { "<leader>ok", "<Cmd>Screenkey<CR>", desc = "Toggle screenkey" } },
    config = true,
  },

  -- music player
  {
    "tamton-aquib/mpv.nvim",
    cmd = "MpvToggle",
    keys = {
      { "<leader>om", "<Cmd>MpvToggle<CR>", desc = "Toggle music player" },
    },
    config = true,
  },

  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm" },
    keys = {
      {
        "<leader>ot",
        "<Cmd>ToggleTerm size=16 dir=%d direction=float<CR>",
        desc = "Toggle terminal",
      },
      { "<leader>ot", "<Cmd>ToggleTerm<CR>", mode = "t", desc = "Toggle terminal" },
    },
    opts = {},
  },

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
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
}
