return {
	{
		"nvim-neorg/neorg",
		cmd = { "Neorg" },
		ft = { "norg" },
		dependencies = {
			{ "nvim-neorg/neorg-telescope" },
			{
				"3rd/image.nvim",
				config = function()
					require("image").setup({
						backend = "kitty",
						integrations = {
							markdown = {
								enabled = false,
							},
							neorg = {
								enabled = true,
								download_remote_images = true,
								clear_in_insert_mode = false,
							},
						},
						max_width = nil,
						max_height = nil,
						max_width_window_percentage = nil,
						max_height_window_percentage = 50,
						kitty_method = "normal",
						window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
						window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
					})
				end,
			},
			-- {
			-- 	"lukas-reineke/headlines.nvim",
			-- 	config = true,
			-- },
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

	-- Neogit
	{
		"NeogitOrg/neogit",
		cmd = { "Neogit" },
		config = true,
		keys = {
			{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
		},
	},

	-- Toggleterm
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
		config = function()
			require("toggleterm").setup()
		end,
	},

	-- Peek
	{
		"toppair/peek.nvim",
		cmd = { "PeekOpen", "PeekClose" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup({
				theme = "light",
			})
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
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
				["<leader>f"] = { name = "+file" },
				["<leader>g"] = { name = "+git" },
				["<leader>h"] = { name = "+help" },
				["<leader>l"] = { name = "+lsp" },
				["<leader>n"] = { name = "+noice" },
				["<leader>o"] = { name = "+open" },
				["<leader>p"] = { name = "+project" },
				["<leader>s"] = { name = "+search/select/session" },
				["<leader>t"] = { name = "+tab/todo" },
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

	-- Measure startup time
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 10
		end,
	},

	-- Session management. This saves your session in the background,
	-- keeping track of open buffers, window arrangement, and more.
	-- You can restore sessions when returning through the dashboard.
	{
		"folke/persistence.nvim",
		enabled = false,
		event = "BufReadPre",
		opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" } },
    -- stylua: ignore
    keys = {
      { "<leader>ss", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>sl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>sd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
	},

	-- Library used by other plugins
	{ "nvim-lua/plenary.nvim", lazy = true },
}
