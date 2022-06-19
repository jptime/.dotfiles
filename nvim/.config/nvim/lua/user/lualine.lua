local get_color = require 'lualine.utils.utils'.extract_highlight_colors

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

require("lualine").setup({
  options = {
    -- ... your lualine config
    theme = "tokyonight",
  },
  sections = {
    lualine_a = { { 'mode', fmt = string.lower } },
    lualine_b = {},
    lualine_c = { { 'b:gitsigns_head', icon = '' }, { 'diff', icon = '', source = diff_source }, {
      'lsp_progress',
      display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' } },
      spinner_symbols = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
    }
    },
    lualine_x = { 'filetype' },
    lualine_y = {},
    lualine_z = { {
      'diagnostics',
      symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
      colored = true,
      diagnostics_color = {
        error = { fg = get_color("DiagnosticSignError", "fg") },
        warn = { fg = get_color("DiagnosticSignWarn", "fg") },
        info = { fg = get_color("DiagnosticSignInfo", "fg") },
        hint = { fg = get_color("DiagnosticSignHint", "fg") },
      },
    } }
    -- lualine_a = {
    --   'diagnostics',
    --   -- Table of diagnostic sources, available sources are:
    --   --   'nvim_lsp', 'nvim_diagnostic', 'coc', 'ale', 'vim_lsp'.
    --   -- or a function that returns a table as such:
    --   --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
    --   sources = { 'nvim_diagnostic', 'coc' },
    --
    --   -- Displays diagnostics for the defined severity types
    --   sections = { 'error', 'warn', 'info', 'hint' },
    --
    --   diagnostics_color = {
    --     -- Same values as the general color option can be used here.
    --     error = 'DiagnosticError', -- Changes diagnostics' error color.
    --     warn  = 'DiagnosticWarn', -- Changes diagnostics' warn color.
    --     info  = 'DiagnosticInfo', -- Changes diagnostics' info color.
    --     hint  = 'DiagnosticHint', -- Changes diagnostics' hint color.
    --   },
    --   symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
    --   colored = true, -- Displays diagnostics status in color if set to true.
    --   update_in_insert = false, -- Update diagnostics in insert mode.
    --   always_visible = false, -- Show diagnostics even if there are none.
    -- }
    -- } -- ... your lualine config
  },
})
