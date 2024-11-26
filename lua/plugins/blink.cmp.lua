local util = require("util")

if util.uname() ~= "nixos" then
  return {}
end

return {
  "saghen/blink.cmp",
  build = "cargo build --release",
}
