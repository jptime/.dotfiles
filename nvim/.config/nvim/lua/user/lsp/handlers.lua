-- Set Default Prefix.
-- Note: You can set a prefix per lsp server in the lv-globals.lua file
local M = {}

function M.setup()
  local config = { -- your config
    virtual_text = user.lsp.diagnostics.virtual_text,
    signs = user.lsp.diagnostics.signs,
    underline = user.lsp.diagnostics.underline,
    update_in_insert = user.lsp.diagnostics.update_in_insert,
    severity_sort = user.lsp.diagnostics.severity_sort,
    float = user.lsp.diagnostics.float,
  }
  vim.diagnostic.config(config)
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, user.lsp.float)
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, user.lsp.float)
end

return M
