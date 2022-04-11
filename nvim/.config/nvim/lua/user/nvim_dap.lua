local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>dc", '<cmd>lua require"dap".continue()<CR>', opts)
keymap("n", "<leader>dsv", '<cmd>lua require"dap".step_over()<CR>', opts)
keymap("n", "<leader>dsi", '<cmd>lua require"dap".step_into()<CR>', opts)
keymap("n", "<leader>dso", '<cmd>lua require"dap".step_out()<CR>', opts)
keymap("n", "<leader>dtb", '<cmd>lua require"dap".toggle_breakpoint()<CR>', opts)
keymap("n", "<leader>dsbr", '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', opts)
keymap(
	"n",
	"<leader>dsbm",
	'<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
	opts
)
keymap("n", "<leader>dro", '<cmd>lua require"dap".repl.open()<CR>', opts)
keymap("n", "<leader>drl", '<cmd>lua require"dap".repl.run_last()<CR>', opts)

-- telescope-dap
-- keymap("n", "<leader>dcc", '<cmd>lua require"telescope".extensions.dap.commands{}<CR>')
-- keymap("n", "<leader>dco", '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>')
-- keymap("n", "<leader>dlb", '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>')
-- keymap("n", "<leader>dv", '<cmd>lua require"telescope".extensions.dap.variables{}<CR>')
-- keymap("n", "<leader>df", '<cmd>lua require"telescope".extensions.dap.frames{}<CR>')

local dap = require("dap")
dap.adapters.ruby = {
	type = "executable",
	command = "bundle",
	args = { "exec", "rdbg", "stdio" },
}

-- dap.configurations.ruby = {
--   {
--     type = 'ruby';
--     request = 'launch';
--     name = 'Rails';
--     program = 'bundle';
--     programArgs = {'exec', '', 's'};
--     useBundler = true;
--   },
-- }
