return {
  -- Cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind.nvim",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        version = "2.*",
        dependencies = {
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
              require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/" } })
            end,
          },
        },
        opts = {
          history = true,
          delete_check_events = "TextChanged",
        },
      },
      {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = {
          lsp = {
            enabled = true,
            on_attach = function(client, bufnr)
              -- the same on_attach function as for your other lsp's
            end,
            actions = true,
            completion = true,
            hover = true,
          },
        },
      },
    },
    version = false, -- last release is way too old
    event = "InsertEnter",
    config = require("config.cmp"),
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Fast and feature-rich surround actions. For text that includes
  -- surrounding characters like brackets or quotes, this allows you
  -- to select the text inside, change or modify the surrounding characters,
  -- and more.
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },

  -- Comment
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      mappings = {
        comment = "<C-c>",
        comment_line = "<C-c>",
        comment_visual = "<C-c>",
        textobject = "<C-c>",
      },
    },
  },

  -- Better text-objects
  {
    "echasnovski/mini.ai",
    keys = {
      { "a", mode = { "x", "o" } },
      { "i", mode = { "x", "o" } },
    },
    event = "VeryLazy",
    dependencies = { "nvim-treesitter-textobjects" },
    config = require("config.mini_ai"),
  },

  {
    "echasnovski/mini.align",
    version = false,
    opts = {},
  },

  -- copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    event = "VeryLazy",
    opts = {},
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    event = "VeryLazy",
    keys = {
      -- Show help actions with telescope
      {
        "<leader>ch",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.help_actions())
        end,
        desc = "CopilotChat - Help actions",
      },
      -- Show prompts actions with telescope
      {
        "<leader>cp",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "CopilotChat - Prompt actions",
      },
      -- Code related commands
      { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<leader>ct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
      { "<leader>cr", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
      { "<leader>cR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
      { "<leader>cn", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
      -- Chat with Copilot in visual mode
      {
        "<leader>cv",
        ":CopilotChatVisual",
        mode = "x",
        desc = "CopilotChat - Open in vertical split",
      },
      {
        "<leader>cx",
        ":CopilotChatInline<cr>",
        mode = "x",
        desc = "CopilotChat - Inline chat",
      },
      -- Custom input for CopilotChat
      {
        "<leader>ci",
        function()
          local input = vim.fn.input("Ask Copilot: ")
          if input ~= "" then
            vim.cmd("CopilotChat " .. input)
          end
        end,
        desc = "CopilotChat - Ask input",
      },
      -- Generate commit message based on the git diff
      {
        "<leader>cm",
        "<cmd>CopilotChatCommit<cr>",
        desc = "CopilotChat - Generate commit message for all changes",
      },
      {
        "<leader>cM",
        "<cmd>CopilotChatCommitStaged<cr>",
        desc = "CopilotChat - Generate commit message for staged changes",
      },
      -- Quick chat with Copilot
      {
        "<leader>cq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            vim.cmd("CopilotChatBuffer " .. input)
          end
        end,
        desc = "CopilotChat - Quick chat",
      },
      -- Debug
      { "<leader>cd", "<cmd>CopilotChatDebugInfo<cr>", desc = "CopilotChat - Debug Info" },
      -- Fix the issue with diagnostic
      { "<leader>cf", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
      -- Clear buffer and chat history
      { "<leader>cl", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Clear buffer and chat history" },
      -- Toggle Copilot Chat Vsplit
      { "<leader>cv", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
    },
    opts = {
      question_header = "## User ",
      answer_header = "## Copilot ",
      error_header = "## Error ",
      separator = " ", -- Separator to use in chat
      prompts = {
        -- Code related prompts
        Explain = "Please explain how the following code works.",
        Review = "Please review the following code and provide suggestions for improvement.",
        Tests = "Please explain how the selected code works, then generate unit tests for it.",
        Refactor = "Please refactor the following code to improve its clarity and readability.",
        FixCode = "Please fix the following code to make it work as intended.",
        FixError = "Please explain the error in the following text and provide a solution.",
        BetterNamings = "Please provide better names for the following variables and functions.",
        Documentation = "Please provide documentation for the following code.",
        SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
        SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
        -- Text related prompts
        Summarize = "Please summarize the following text.",
        Spelling = "Please correct any grammar and spelling errors in the following text.",
        Wording = "Please improve the grammar and wording of the following text.",
        Concise = "Please rewrite the following text to make it more concise.",
      },
      auto_follow_cursor = false, -- Don't follow the cursor after getting response
      show_help = false, -- Show help in virtual text, set to true if that's 1st time using Copilot Chat
      mappings = {
        -- Use tab for completion
        complete = {
          detail = "Use @<Tab> or /<Tab> for options.",
          insert = "<Tab>",
        },
        -- Close the chat
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        -- Reset the chat buffer
        reset = {
          normal = "<C-l>",
          insert = "<C-l>",
        },
        -- Submit the prompt to Copilot
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-CR>",
        },
        -- Accept the diff
        accept_diff = {
          normal = "<C-y>",
          insert = "<C-y>",
        },
        -- Yank the diff in the response to register
        yank_diff = {
          normal = "gmy",
        },
        -- Show the diff
        show_diff = {
          normal = "gmd",
        },
        -- Show the prompt
        show_system_prompt = {
          normal = "gmp",
        },
        -- Show the user selection
        show_user_selection = {
          normal = "gms",
        },
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      local select = require("CopilotChat.select")
      -- Use unnamed register for the selection
      opts.selection = select.unnamed

      -- Override the git prompts message
      opts.prompts.Commit = {
        prompt = "Write commit message for the change with commitizen convention",
        selection = select.gitdiff,
      }
      opts.prompts.CommitStaged = {
        prompt = "Write commit message for the change with commitizen convention",
        selection = function(source)
          return select.gitdiff(source, true)
        end,
      }

      chat.setup(opts)

      vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
        chat.ask(args.args, { selection = select.visual })
      end, { nargs = "*", range = true })

      -- Inline chat with Copilot
      vim.api.nvim_create_user_command("CopilotChatInline", function(args)
        chat.ask(args.args, {
          selection = select.visual,
          window = {
            layout = "float",
            relative = "cursor",
            width = 1,
            height = 0.4,
            row = 1,
          },
        })
      end, { nargs = "*", range = true })

      -- Restore CopilotChatBuffer
      vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
        chat.ask(args.args, { selection = select.buffer })
      end, { nargs = "*", range = true })

      -- Custom buffer for CopilotChat
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-*",
        callback = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.number = true

          -- Get current filetype and set it to markdown if the current filetype is copilot-chat
          local ft = vim.bo.filetype
          if ft == "copilot-chat" then
            vim.bo.filetype = "markdown"
          end
        end,
      })

      -- Add which-key mappings
      local wk = require("which-key")
      wk.register({
        g = {
          m = {
            name = "+Copilot Chat",
            d = "Show diff",
            p = "System prompt",
            s = "Show selection",
            y = "Yank diff",
          },
        },
      })
    end,
  },

  {
    "vidocqh/auto-indent.nvim",
    opts = {
      indentexpr = function(lnum)
        return require("nvim-treesitter.indent").get_indent(lnum)
      end,
    },
  },
}
