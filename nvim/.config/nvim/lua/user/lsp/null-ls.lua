local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null%2D;ls.nvim/tree/main/lua/null-ls/builtins/code_actions
local code_actions = null_ls.builtins.code_actions

_G.formatting = function(bufnr)
	bufnr = tonumber(bufnr) or vim.api.nvim_get_current_buf()

	vim.lsp.buf_request(
		bufnr,
		"textDocument/formatting",
		{ textDocument = { uri = vim.uri_from_bufnr(bufnr) } },
		function(err, res)
			if err then
				local err_msg = type(err) == "string" and err or err.message
				-- you can modify the log message / level (or ignore it completely)
				vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
				return
			end

			-- don't apply results if buffer is unloaded or has been modified
			if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
				return
			end

			if res then
				vim.lsp.util.apply_text_edits(res, bufnr)
				vim.api.nvim_buf_call(bufnr, function()
					vim.cmd("silent noautocmd update")
				end)
			end
		end
	)
end

null_ls.setup({
	debug = true,
	sources = {
		formatting.prettier.with({
			prefer_local = "node_modules/.bin",
		}),
		formatting.eslint.with({
			prefer_local = "node_modules/.bin",
		}),
		diagnostics.eslint.with({
			prefer_local = "node_modules/.bin",
		}),
		code_actions.eslint.with({
			prefer_local = "node_modules/.bin",
		}),
		diagnostics.golangci_lint,
		formatting.gofmt,
		formatting.rubocop,
		formatting.stylua,
		-- code_actions.gitsigns,
	},
	on_attach = function(client)
		if client.server_capabilities.document_formatting then
			vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.format { async = true }
            augroup END
            ]])
		end
	end,
	-- on_attach = function(client)
	-- 	if client.supports_method("textDocument/formatting") then
	-- 		-- wrap in an augroup to prevent duplicate autocmds
	-- 		vim.cmd([[
	-- 	          augroup LspFormatting
	-- 	              autocmd! * <buffer>
	-- 	              autocmd BufWritePost <buffer> lua formatting(vim.fn.expand("<abuf>"))
	-- 	          augroup END
	-- 	          ]])
	-- 	elseif client.resolved_capabilities.document_formatting then
	-- 		vim.cmd([[
	-- 	    augroup LspFormatting
	-- 	        autocmd! * <buffer>
	-- 	        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
	-- 	    augroup END
	-- 	    ]])
	-- 	end
	-- end,
})
