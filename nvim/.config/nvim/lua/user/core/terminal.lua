local M = {}
local Log = require "user.core.log"

M.config = function()
  user.builtin["terminal"] = {
    on_config_done = nil,
    -- size can be a number or function which is passed the current terminal
    size = 20,
    -- open_mapping = [[<c-\>]],
    open_mapping = [[<c-t>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = false,
    -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
    direction = "float",
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
      -- The border key is *almost* the same as 'nvim_win_open'
      -- see :h nvim_win_open for details on borders however
      -- the 'curved' border is a custom border type
      -- not natively supported but implemented in this plugin.
      -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
      border = "curved",
      -- width = <value>,
      -- height = <value>,
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
    -- Add executables on the config.lua
    -- { exec, keymap, name}
    -- user.builtin.terminal.execs = {{}} to overwrite
    -- user.builtin.terminal.execs[#user.builtin.terminal.execs+1] = {"gdb", "tg", "GNU Debugger"}
    execs = {
      { "lazygit", "<leader>gg", "LazyGit", "float" },
      { "lazygit", "<c-\\><c-g>", "LazyGit", "float" },
    },
  }
end

M.setup = function()
  local terminal = require "toggleterm"
  terminal.setup(user.builtin.terminal)

  for i, exec in pairs(user.builtin.terminal.execs) do
    local opts = {
      cmd = exec[1],
      keymap = exec[2],
      label = exec[3],
      -- NOTE: unable to consistently bind id/count <= 9, see #2146
      count = i + 100,
      direction = exec[4] or user.builtin.terminal.direction,
      size = user.builtin.terminal.size,
    }

    M.add_exec(opts)
  end

  if user.builtin.terminal.on_config_done then
    user.builtin.terminal.on_config_done(terminal)
  end
end

M.add_exec = function(opts)
  local binary = opts.cmd:match "(%S+)"
  if vim.fn.executable(binary) ~= 1 then
    Log:debug("Skipping configuring executable " .. binary .. ". Please make sure it is installed properly.")
    return
  end

  local exec_func = string.format(
    "<cmd>lua require('user.core.terminal')._exec_toggle({ cmd = '%s', count = %d, direction = '%s'})<CR>",
    opts.cmd,
    opts.count,
    opts.direction
  )

  require("user.keymappings").load {
    normal_mode = { [opts.keymap] = exec_func },
    term_mode = { [opts.keymap] = exec_func },
  }

  local wk_status_ok, wk = pcall(require, "which-key")
  if not wk_status_ok then
    return
  end
  wk.register({ [opts.keymap] = { opts.label } }, { mode = "n" })
end

M._exec_toggle = function(opts)
  local Terminal = require("toggleterm.terminal").Terminal
  local term = Terminal:new { cmd = opts.cmd, count = opts.count, direction = opts.direction }
  term:toggle(user.builtin.terminal.size, opts.direction)
end

---Toggles a log viewer according to log.viewer.layout_config
---@param logfile string the fullpath to the logfile
M.toggle_log_view = function(logfile)
  local log_viewer = user.log.viewer.cmd
  if vim.fn.executable(log_viewer) ~= 1 then
    log_viewer = "less +F"
  end
  Log:debug("attempting to open: " .. logfile)
  log_viewer = log_viewer .. " " .. logfile
  local term_opts = vim.tbl_deep_extend("force", user.builtin.terminal, {
    cmd = log_viewer,
    open_mapping = user.log.viewer.layout_config.open_mapping,
    direction = user.log.viewer.layout_config.direction,
    -- TODO: this might not be working as expected
    size = user.log.viewer.layout_config.size,
    float_opts = user.log.viewer.layout_config.float_opts,
  })

  local Terminal = require("toggleterm.terminal").Terminal
  local log_view = Terminal:new(term_opts)
  log_view:toggle()
end

return M
