if not vim.g.neovide then
  return
end

local g = vim.g

vim.opt.guifont = { "JetBrainsMono Nerd Font Mono", "Source Han Sans SC", ":h16" }

g.neovide_padding_top = 0
g.neovide_padding_bottom = 0
g.neovide_padding_right = 30
g.neovide_padding_left = 30

g.neovide_transparency = 0.8

g.neovide_refresh_rate = 60
g.neovide_refresh_rate_idle = 5

g.neovide_scroll_animation_length = 0.2

g.neovide_floating_shadow = false
g.neovide_floating_blur_amount_x = 0
g.neovide_floating_blur_amount_y = 0

g.neovide_fullscreen = true

g.neovide_hide_mouse_when_typing = true

g.neovide_cursor_antialiasing = false
g.neovide_cursor_animate_in_insert_mode = true
g.neovide_cursor_animate_command_line = true
g.neovide_cursor_vfx_mode = "railgun"
g.neovide_cursor_vfx_particle_density = 10.0
