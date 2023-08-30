-- This file is automatically loaded by plugins.core
vim.g.mapleader = " "
vim.g.maplocalleader = ","

local opt = vim.opt

opt.autoread = true
opt.autowrite = true -- Enable auto write
opt.backspace = "2"
opt.backup = true
opt.backupdir = vim.fn.stdpath("state") .. "/backup"
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.cmdheight = 0
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 0
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "" -- Disable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true })
opt.showcmd = true
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.textwidth = 80
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.whichwrap = "b,s,<,>,[,]"
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width

-- Nvim 0.9+
opt.splitkeep = "screen"
opt.shortmess:append({ C = true })

local wo = vim.wo

wo.number = true
wo.cursorline = true
wo.cursorlineopt = "number"

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

vim.g.loader_python3_provider = 0
vim.g.loader_perl_provider = 0
vim.g.loader_ruby_provider = 0
vim.g.loader_node_provider = 0

vim.opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldcolumn = "0"

if vim.g.neovide then
	vim.opt.guifont = { "JetBrainsMono Nerd Font Mono", ":h12" }
	vim.g.neovide_scale_factor = 1.2
	vim.g.neovide_hide_mouse_when_typing = true
end
