local M = {}
local builtinPair = {
  "user.core.which-key",
  "user.core.notify",
  "user.core.telescope",
  "user.core.lualine",
  "user.core.autopairs",
  "user.core.nvimtree",
  "user.core.treesitter",
  "user.core.gitsigns",
  "user.core.comment",
  "user.core.project",
  "user.core.bufferline",
  "user.core.dap",
  "user.core.terminal",
  "user.core.cmp",
}
--  "user.core.terminal",

function M.config(config)
  for _, builtin_path in ipairs(builtinPair) do
    local builtinz = require(builtin_path)
    builtinz.config(config)
  end
end

return M
