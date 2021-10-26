require("toggleterm").setup{
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  close_on_exit = true, -- close the terminal window when the process exits
  -- shell = vim.o.shell -- change the default shell
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = 'single', 
    -- width = <value>,
    -- height = <value>,
    highlights = {
      border = "Normal",
      background = "Normal",
    }
  }
}
