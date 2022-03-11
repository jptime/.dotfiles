local opts = {
	-- settings = {
	-- 	format = { enable = true }, -- this will enable formatting
	-- },
	-- on_attach = function(client, bufnr)
	-- 	-- neovim's LSP client does not currently support dynamic capabilities registration, so we need to set
	-- 	-- the resolved capabilities of the eslint server ourselves!
	-- 	client.resolved_capabilities.document_formatting = true
	-- 	-- common_on_attach(client, bufnr)
	-- end,
}
return opts
