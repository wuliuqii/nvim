-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Movement
map({ "n", "v" }, "gh", "^", { desc = "Begin of line" })
map({ "n", "v" }, "gl", "$", { desc = "End of line" })
map("n", "ge", "G", { desc = "End line" })

-- Emacs like keybinding
--
-- Movement
map("!", "<C-b>", "<Left>", { desc = "Backward char" })
map("!", "<C-f>", "<Right>", { desc = "Forward char" })
map("i", "<C-p>", "<Up>", { desc = "Previous line" })
map("i", "<C-n>", "<Down>", { desc = "Next line" })
map("!", "<C-a>", "<Home>", { desc = "Begin of line" })
map("!", "<C-e>", "<End>", { desc = "End of line" })
map("i", "<M-a>", "<C-o>(", { desc = "Backward sentence" })
map("i", "<M-e>", "<C-o>)", { desc = "Forward sentence" })
map("i", "<M-b>", "<C-Left>", { desc = "Backward word" })
map("c", "<M-b>", "<S-Left>", { desc = "Backward word" })
map("i", "<M-f>", "<C-o>e<Right>", { desc = "Forward word" })
map("c", "<M-f>", "<S-Right>", { desc = "Forward word" })

--- Editing
--
-- esc
map("!", "<C-g>", "<Esc>", { desc = "Esc" })

--undo
map("!", "<C-/>", "<Cmd>undo<Cr>", { desc = "Undo" })

-- kill
map("!", "<C-d>", "<Del>", { desc = "Delete char" })
map("!", "<M-BS>", "<C-w>", { silent = true })
map("i", "<C-BS>", "<C-w>", { silent = true })

map("i", "<M-d>", function()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()

  if #line <= col then
    return "<Del><C-o>dw"
  end

  return "<C-o>dw"
end, { desc = "Kill word", expr = true })

-- map("i", "<C-k>", function()
-- 	local col = vim.api.nvim_win_get_cursor(0)[2]
-- 	local line = vim.api.nvim_get_current_line()
--
-- 	if #line <= col then
-- 		return "<Del>"
-- 	end
--
-- 	return "<C-o>d$"
-- end, { desc = "Kill line", expr = true })

-- Delete lazyvim global keymaps
local del = vim.keymap.del

del("n", "<leader>-")
del("n", "<leader>|")

del("n", "<leader>ft")
del("n", "<leader>fT")

del("n", "<leader>gG")
