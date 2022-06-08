local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {
      on_attach = require("user.lsp.handlers").on_attach,
      capabilities = require("user.lsp.handlers").capabilities,
    log_level = vim.log.levels.DEBUG,

    }
    if server.name == "jsonls" then 
        local jsonls_opts = require("user.lsp.settings.jsonls")
        opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

    if server.name == "tsserver" then
      local tsserver_opts = require("user.lsp.settings.tsserver")
      opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
  end

    if server.name == "sumneko_lua" then
    	local sumneko_opts = require("user.lsp.settings.sumneko_lua")
    	opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    if server.name == "solargraph" then
    local solargraph_opts = {}
    	opts = vim.tbl_deep_extend("force", solargraph_opts, opts)
    end

    if server.name == "gopls" then
    local gopls_opts = {}
    	opts = vim.tbl_deep_extend("force", gopls_opts, opts)
    end

    if server.name == "golangci_lint" then
    local golangci_lint_opts = {}
    	opts = vim.tbl_deep_extend("force", golangci_lint_opts, opts)
    end

    if server.name == "clangd" then
    local clangd_opts = require'lspconfig'.clangd.setup{}
    	opts = vim.tbl_deep_extend("force", clangd_opts, opts)
    end

    if server.name == "arduino-language-server" then
      local MY_FQBN = "esp32:esp32:esp32"
      lspconfig.arduino_language_server.setup {
          cmd = {
              "arduino-language-server",
              "-cli-config", "/Users/johnpetty/Library/Arduino15/arduino-cli.yaml",
              "-fqbn", MY_FQBN,
              "-cli-daemon-addr", "localhost",
              "-cli-daemon-instance", "1",
              "-clangd", "/usr/bin/clang"
          }
      }
  end
  
    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)
