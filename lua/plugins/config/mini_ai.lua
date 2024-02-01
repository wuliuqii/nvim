local function on_load(name, fn)
  local Config = require("lazy.core.config")
  if Config.plugins[name] and Config.plugins[name]._.loaded then
    fn(name)
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

return function()
  local ai = require("mini.ai")

  ai.setup({
    n_lines = 500,
    custom_textobjects = {
      o = ai.gen_spec.treesitter({
        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
      }, {}),
      f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
      c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
      t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
    },
  })

  on_load("which-key.nvim", function()
    ---@type table<string, string|table>
    local i = {
      [" "] = "Whitespace",
      ['"'] = 'Balanced "',
      ["'"] = "Balanced '",
      ["`"] = "Balanced `",
      ["("] = "Balanced (",
      [")"] = "Balanced ) including white-space",
      [">"] = "Balanced > including white-space",
      ["<lt>"] = "Balanced <",
      ["]"] = "Balanced ] including white-space",
      ["["] = "Balanced [",
      ["}"] = "Balanced } including white-space",
      ["{"] = "Balanced {",
      ["?"] = "User Prompt",
      _ = "Underscore",
      a = "Argument",
      b = "Balanced ), ], }",
      c = "Class",
      f = "Function",
      o = "Block, conditional, loop",
      q = "Quote `, \", '",
      t = "Tag",
    }
    local a = vim.deepcopy(i)
    for k, v in pairs(a) do
      a[k] = v:gsub(" including.*", "")
    end

    local ic = vim.deepcopy(i)
    local ac = vim.deepcopy(a)
    for key, name in pairs({ n = "Next", l = "Last" }) do
      i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
      a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
    end
    require("which-key").register({
      mode = { "o", "x" },
      i = i,
      a = a,
    })
  end)
end
