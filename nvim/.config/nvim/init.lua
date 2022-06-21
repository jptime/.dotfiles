-- require("user.options")
-- require("user.keymaps")
-- require("user.plugins")
--
-- require("user.lsp.init")
--
-- require("user.autopairs")
-- require("user.cmp")
-- require("user.colorscheme")
-- require("user.comment")
-- require("user.lualine")
-- require("user.bufferline")
-- require("user.gitsigns")
-- require("user.impatient")
-- require("user.indent-blankline")
-- -- require("user.nvim_dap")
-- -- require("user.nvim_dap_install")
-- require("user.nvim-tree")
-- require("user.package_info")
-- require("user.project")
-- require("user.stabilize")
-- require("user.telescope")
-- -- require("user.toggle_term")
-- require("user.treesitter")
-- require("user.which-key")
--
-- require("user.core.builtins").config()
-- require("user.lsp").setup()
-- builtins.config { user_config_file = user_config_file }
local init_path = debug.getinfo(1, "S").source:sub(2)
local base_dir = init_path:match("(.*[/\\])"):sub(1, -2)

if not vim.tbl_contains(vim.opt.rtp:get(), base_dir) then
  vim.opt.rtp:append(base_dir)
end

require("user.bootstrap"):init(base_dir)

require("user.config"):load()

local plugins = require "user.plugins"
require("user.plugin-loader").load { plugins, user.plugins }

local Log = require "user.core.log"
Log:debug "Starting DUMPVim"

--local commands = require "user.core.commands"
--commands.load(commands.defaults)

require("user.lsp").setup()
