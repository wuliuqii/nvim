local M = {}

function M.uname()
  local handle = io.popen("uname -a")
  if handle then
    local res = handle:read("a")
    handle:close()
    return string.match(res, "nixos")
  end
  return nil
end

return M
