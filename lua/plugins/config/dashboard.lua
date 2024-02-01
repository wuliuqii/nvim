return function()
  local opts = {
    theme = "doom",
    hide = {
      statusline = false,
    },
    config = {
      header = {
        [[          ____          ]],
        [[         /.../\         ]],
        [[        /.../--\        ]],
        [[       /.../----\       ]],
        [[      /.../------\      ]],
        [[     /.../---/\---\     ]],
        [[    /.../---/\\\---\    ]],
        [[   /.../---/\\\\\---\   ]],
        [[  /.../===/__\\\\\---\  ]],
        [[ /............\\\\\---\ ]],
        [[/..............\\\\\---\]],
        [[\\\\\\\\\\\\\\\\\\\\\--/]],
        [[ \\\\\\\\\\\\\\\\\\\\\/ ]],
        [[                        ]],
      },
      -- stylua: ignore
      center = {
        { action = "Telescope fd"                     , desc = "File Browser"    , icon = "  ", key = "f" },
        { action = "Telescope oldfiles"               , desc = "Recent Files"    , icon = "  ", key = "r" },
        { action = "Telescope project"                , desc = "Projects"        , icon = "  ", key = "p" },
        { action = "Lazy"                             , desc = "Plugins"         , icon = "  ", key = "u" },
        { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " " , key = "s" },
        { action = "qa"                               , desc = " Quit"           , icon = " " , key = "q" },
      },
      footer = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        return {
          "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
        }
      end,
    },
  }

  -- close Lazy and re-open when the dashboard is ready
  if vim.o.filetype == "lazy" then
    vim.cmd.close()
    vim.api.nvim_create_autocmd("User", {
      pattern = "DashboardLoaded",
      callback = function()
        require("lazy").show()
      end,
    })
  end

  return opts
end
