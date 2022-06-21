local M = {}
local Log = require "user.core.log"
local utils = require "user.utils"
local autocmds = require "user.core.autocmds"

local function add_lsp_buffer_keybindings(bufnr)
  local mappings = {
    normal_mode = "n",
    insert_mode = "i",
    visual_mode = "v",
  }

    -- Remap using which_key
    local status_ok, wk = pcall(require, "which-key")
    if not status_ok then
      return
    end
    for mode_name, mode_char in pairs(mappings) do
      wk.register(user.lsp.buffer_mappings[mode_name], { mode = mode_char, buffer = bufnr })
    end
end

function M.common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
  end

  return capabilities
end

function M.common_on_exit(_, _)
    autocmds.clear_augroup "lsp_document_highlight"
    autocmds.clear_augroup "lsp_code_lens_refresh"
end

function M.common_on_init(client, bufnr)
  if user.lsp.on_init_callback then
    user.lsp.on_init_callback(client, bufnr)
    Log:debug "Called lsp.on_init_callback"
    return
  end
end

function M.common_on_attach(client, bufnr)
  if user.lsp.on_attach_callback then
    user.lsp.on_attach_callback(client, bufnr)
    Log:debug "Called lsp.on_attach_callback"
  end
  local lu = require "user.lsp.utils"
  if user.lsp.document_highlight then
    lu.setup_document_highlight(client, bufnr)
  end
  if user.lsp.code_lens_refresh then
    lu.setup_codelens_refresh(client, bufnr)
  end
  add_lsp_buffer_keybindings(bufnr)
end

local function bootstrap_nlsp(opts)
  opts = opts or {}
  local lsp_settings_status_ok, lsp_settings = pcall(require, "nlspsettings")
  if lsp_settings_status_ok then
    lsp_settings.setup(opts)
  end
end

function M.get_common_opts()
  return {
    on_attach = M.common_on_attach,
    on_init = M.common_on_init,
    on_exit = M.common_on_exit,
    capabilities = M.common_capabilities(),
  }
end

function M.setup()
  Log:debug "Setting up LSP support"

  local lsp_status_ok, _ = pcall(require, "lspconfig")
  if not lsp_status_ok then
    return
  end

  if user.use_icons then
    for _, sign in ipairs(user.lsp.diagnostics.signs.values) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
    end
  end

  require("user.lsp.handlers").setup()

  if not utils.is_directory(user.lsp.templates_dir) then
    require("user.lsp.templates").generate_templates()
  end

  bootstrap_nlsp {
    config_home = utils.join_paths(get_config_dir(), "lsp-settings"),
    append_default_schemas = true,
  }

  require("nvim-lsp-installer").setup {
    -- use the default nvim_data_dir, since the server binaries are independent
    install_root_dir = utils.join_paths(vim.call("stdpath", "data"), "lsp_servers"),
  }

  require("user.lsp.null-ls").setup()

  autocmds.configure_format_on_save()
end

return M
