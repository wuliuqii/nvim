return {
  "nvimdev/dashboard-nvim",
  opts = {
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
        { action = "Telescope fd"                     , desc = "File Browser"    , icon = " ", key = "f" },
        { action = "Telescope oldfiles"               , desc = "Recent Files"    , icon = " ", key = "r" },
        { action = "Lazy"                             , desc = "Lazy"            , icon = "󰒲 ", key = "l" },
        { action = "LazyExtras"                      , desc = "Lazy Extras"     , icon = " ", key = "x" },
        { action = 'lua require("persistence").load()', desc = "Restore Session" , icon = " ", key = "s" },
        { action = "qa"                               , desc = "Quit"            , icon = " ", key = "q" },
      },
      footer = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        return {
          "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
        }
      end,
    },
  },
}
