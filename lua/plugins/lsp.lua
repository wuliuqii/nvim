---@diagnostic disable: unused-local
return {
	-- LSP config
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"folke/neodev.nvim",
				opts = {},
			},
		},
		config = function()
			-- Setup language servers
			local lspconfig = require("lspconfig")
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			capabilities.textDocument.completion.completionItem.resolveSupport = {
				properties = { "documentation", "detail", "additionalTextEdits" },
			}
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { "vim" },
						},
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						-- Do not send telemetry data containing a randomized but unique identifier
						telemetry = {
							enable = false,
						},
					},
				},
			})
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							runBuildScripts = true,
						},
						checkOnSave = {
							command = "clippy",
							extraArgs = {
								"--no-deps",
							},
							allFeatures = true,
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
			})
			lspconfig.taplo = {}
			lspconfig.gopls.setup({
				capabilities = capabilities,
				settings = {
					gopls = {
						gofumpt = true,
						codelenses = {
							gc_details = false,
							generate = true,
							regenerate_cgo = true,
							run_govulncheck = true,
							test = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
						analyses = {
							fieldalignment = true,
							nilness = true,
							unusedparams = true,
							unusedwrite = true,
							useany = true,
						},
						usePlaceholders = true,
						completeUnimported = true,
						staticcheck = true,
						directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
						semanticTokens = true,
					},
				},
			})
			lspconfig.nil_ls.setup({ capabilities = capabilities })

			-- Diagnostics
			local signs = {
				Error = " ",
				Warn = " ",
				Hint = " ",
				Info = " ",
			}
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Diagnostics go to previous" })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Diagnostics go to next" })

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					vim.keymap.set(
						"n",
						"<leader>lwa",
						vim.lsp.buf.add_workspace_folder,
						{ buffer = ev.buf, desc = "Add workspace folder" }
					)
					vim.keymap.set(
						"n",
						"<leader>lwr",
						vim.lsp.buf.remove_workspace_folder,
						{ buffer = ev.buf, desc = "Remove workspace folder" }
					)
					vim.keymap.set("n", "<leader>lwl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, { buffer = ev.buf, desc = "List workspace folders" })
				end,
			})
		end,
	},

	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		config = function()
			-- Highlights
			vim.api.nvim_set_hl(0, "SagaNormal", { link = "Normal" })
			vim.api.nvim_set_hl(0, "SagaBorder", { link = "Normal" })
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "*",
				callback = function()
					vim.api.nvim_set_hl(0, "SagaNormal", { link = "Normal" })
					vim.api.nvim_set_hl(0, "SagaBorder", { link = "Normal" })
				end,
			})
			require("lspsaga").setup({
				code_action = {
					keys = {
						quit = { "q", "<Esc>" },
					},
				},
				ui = {
					border = "rounded",
					winblend = 1,
					lines = { "└", "├", "│", "─" },
				},
				outline = {
					keys = {
						quit = "q",
						toggle_or_jump = "<CR>",
					},
				},
				definition = {
					quit = { "q", "<Esc>" },
				},
				finder = {
					auto_close = true,
					auto_preview = true,
					keys = {
						toggle_or_open = "<CR>",
						quit = { "q", "<ESC>" },
					},
				},
			})

			local goto_definition_stack = {}

			local function goto_definition_mark()
				-- Insert current buffer position into a stack before jumping to definition
				local curr_buff = vim.api.nvim_get_current_buf()
				local cursor_pos = vim.api.nvim_win_get_cursor(0)
				local marker_info = { curr_buff, cursor_pos }
				table.insert(goto_definition_stack, marker_info)
				vim.cmd("Lspsaga goto_definition")
			end

			local function go_back_from_definition()
				-- Get last mark in the go to definition stack
				local marker_info = table.remove(goto_definition_stack)

				if not marker_info then
					return
				end

				local buff_info, cursor_info = marker_info[1], marker_info[2]
				vim.api.nvim_set_current_buf(buff_info)
				vim.api.nvim_win_set_cursor(0, cursor_info)
			end

			-- Keymaps
			vim.keymap.set("n", "gd", "<Cmd>Lspsaga peek_definition<CR>", { desc = "Peek to definition" })
			vim.keymap.set("n", "gD", goto_definition_mark, { desc = "Jump to definition" })
			vim.keymap.set("n", "gb", go_back_from_definition, { desc = "Jump back from definition" })
			vim.keymap.set("n", "gr", "<Cmd>Lspsaga finder<cr>", { desc = "Finder reference" })
			vim.keymap.set("n", "gi", "<Cmd>Lspsaga finder imp<cr>", { desc = "Finder implementation" })
			vim.keymap.set("n", "<leader>lD", "<Cmd>Lspsaga peek_type_definition<CR>", { desc = "Type definition" })
			vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", { desc = "Hover" })
			vim.keymap.set("n", "<leader>lo", "<Cmd>Lspsaga outline<CR>", { desc = "Show outline" })
			vim.keymap.set("n", "<leader>lr", "<Cmd>Lspsaga rename ++project<CR>", { desc = "Rename in project" })
			vim.keymap.set({ "n", "v" }, "<leader>la", "<Cmd>Lspsaga code_action<CR>", { desc = "Code actions" })
		end,
	},

	-- Navbuddy
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

	-- lsp signature
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

	-- format
	{
		"nvimdev/guard.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvimdev/guard-collection",
		},
		keys = { { "<leader>lf", "<cmd>GuardFmt<cr>", desc = "Guard format" } },
		config = function()
			local ft = require("guard.filetype")
			ft("rust"):fmt("rustfmt")
			ft("go"):fmt("gofmt"):append("golines"):lint({
				cmd = "golangci-lint",
				stdin = true,
			})
			ft("lua"):fmt("stylua")
			ft("nix"):fmt({
				cmd = "nixpkgs-fmt",
				stdin = true,
			})
			ft("json"):fmt("prettier")

			require("guard").setup({
				fmt_on_save = true,
				lsp_as_default_formatter = false,
			})
		end,
	},

	-- Mason
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>om", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {},
		},
	},
}
