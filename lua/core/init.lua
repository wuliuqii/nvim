-- Set the package.path for plugins configuration
package.path = vim.fn.stdpath("config") .. "/lua/plugins/?.lua;" .. package.path
-- package.path = vim.fn.stdpath("config") .. "/lua/plugins/?/init.lua;" .. package.path

-- Set basic VIM configs
require("core.options")
require("core.keymaps")
require("core.autocmd")

-- Bootstrap Lazy.nvim
require("core.lazy")

-- Initialize plugins
require("plugins")
