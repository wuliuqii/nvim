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
        config = true,
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
    -- keys = {
    --   { "a", mode = { "x", "o" } },
    --   { "i", mode = { "x", "o" } },
    -- },
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
    -- event = "InsertEnter",
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
    "jellydn/CopilotChat.nvim",
    branch = "canary", -- Will be merged to main branch when it's stable
    opts = {
      mode = "split", -- newbuffer or split, default: newbuffer
      show_help = "yes", -- Show help text for CopilotChatInPlace, default: yes
      prompts = {
        Explain = "Please explain how the following code works.",
        Review = "Please review the following code and provide suggestions for improvement.",
        Tests = "Please explain how the selected code works, then generate unit tests for it.",
        Refactor = "Please refactor the following code to improve its clarity and readability.",
        -- Text related prompts
        Summarize = "Please summarize the following text.",
        Spelling = "Please correct any grammar and spelling errors in the following text.",
        Wording = "Please improve the grammar and wording of the following text.",
        Concise = "Please rewrite the following text to make it more concise.",
      },
    },
    build = function()
      vim.defer_fn(function()
        vim.cmd("UpdateRemotePlugins")
        vim.notify("CopilotChat - Updated remote plugins. Please restart Neovim.")
      end, 3000)
    end,
    event = "VeryLazy",
    keys = {
      { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<leader>ct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
      { "<leader>cr", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
      { "<leader>cR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
      { "<leader>cs", "<cmd>CopilotChatSummarize<cr>", desc = "CopilotChat - Summarize text" },
      { "<leader>cS", "<cmd>CopilotChatSpelling<cr>", desc = "CopilotChat - Correct spelling" },
      { "<leader>cw", "<cmd>CopilotChatWording<cr>", desc = "CopilotChat - Improve wording" },
      { "<leader>cc", "<cmd>CopilotChatConcise<cr>", desc = "CopilotChat - Make text concise" },
    },
  },
}
