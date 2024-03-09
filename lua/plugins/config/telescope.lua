local function load_extensions()
  require("telescope").load_extension("file_browser")
  require("telescope").load_extension("ui-select")
  require("telescope").load_extension("notify")
  require("telescope").load_extension("project")
  require("telescope").load_extension("fzf")
end

local function telescope_file_browser_conf()
  local fb_action = require("telescope").extensions.file_browser.actions

  return {
    dir_icon = "",
    -- disables netrw and use telescope-file-browser in its place
    hijack_netrw = true,
    mappings = {
      ["i"] = {
        ["<M-CR>"] = fb_action.create_from_prompt, -- Change to <S-CR> when appropriate terminal emulator is installed
      },
    },
  }
end

local function ivy()
  return require("telescope.themes").get_ivy({
    layout_config = {
      height = 0.3,
    },
  })
end

local function find_exact(default)
  local builtin = require("telescope.builtin")
  local opts = ivy()
  opts.default_text = default
  opts.search_dirs = { "%:p" }
  opts.path_display = { "hidden" }
  builtin.live_grep(opts)
end

local function find_under_cursor()
  local word_under_cursor = vim.fn.expand("<cword>")
  find_exact(word_under_cursor)
end

local function conf_keymaps()
  local builtin = require("telescope.builtin")
  local extensions = require("telescope").extensions

  vim.keymap.set("n", "<leader>.", builtin.find_files, { desc = "Find files" })
  vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Git files" })
  vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
  vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
  vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Live grep in project" })
  vim.keymap.set("n", "<leader>,", builtin.buffers, { desc = "Open buffers" })
  vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Describe keymaps" })
  vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
  vim.keymap.set("n", "<leader>fm", builtin.man_pages, { desc = "Man pages" })
  vim.keymap.set("n", "<leader>fc", builtin.colorscheme, { desc = "Colorscheme" })
  -- vim.keymap.set("n", "/", builtin.current_buffer_fuzzy_find, { desc = "Fuzzy find in file" })
  vim.keymap.set("n", "*", find_under_cursor, { desc = "Fuzzy find in file" })
  vim.keymap.set("n", "#", find_under_cursor, { desc = "Fuzzy find in file" })

  -- Extensions keymaps
  vim.keymap.set("n", "<leader>fb", extensions.file_browser.file_browser, { desc = "File browser" })
  vim.keymap.set("n", "<leader>pp", extensions.project.project, { desc = "Project" })
  vim.keymap.set("n", "<M-x>", "<cmd>Telescope commands<cr>", { desc = "Commands" })
end

return function()
  require("telescope").setup({
    defaults = {
      path_display = { "smart" },
      vimgrep_arguments = {
        "rg",
        "-L",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--trim",
        "--glob=!.git/",
      },
      prompt_prefix = " ",
      file_ignore_patterns = { ".git/", ".cache/", ".direnv/" },
    },
    pickers = {
      find_files = ivy(),
      live_grep = ivy(),
      buffers = ivy(),
      current_buffer_fuzzy_find = ivy(),
      lsp_implementations = {
        layout_strategy = "vertical",
        layout_config = {
          width = 0.6,
          height = 0.9,
          preview_cutoff = 1,
          mirror = false,
        },
      },
      lsp_references = {
        layout_strategy = "vertical",
        layout_config = {
          width = 0.6,
          height = 0.9,
          preview_cutoff = 1,
          mirror = false,
        },
      },
      colorscheme = {
        enable_preview = true,
        theme = "dropdown",
        layout_config = {
          anchor = "N",
        },
      },
    },
    extensions = {
      ["file_browser"] = telescope_file_browser_conf(),
    },
  })

  load_extensions()
  conf_keymaps()
end
