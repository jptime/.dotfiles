lua <<EOF
require'nvim-treesitter.configs'.setup {
ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
ignore_install = {}, -- List of parsers to ignore installing
highlight = {
enable = true,              -- false will disable the whole extension
disable = { "c", "rust" },  -- list of language that will be disabled
-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
-- Using this option may slow down your editor, and you may see some duplicate highlights.
-- Instead of true it can also be a list of languages
additional_vim_regex_highlighting = true,
},
}
require'lspconfig'.tsserver.setup{

}
require'lspconfig'.vimls.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.solargraph.setup{}
require'lspconfig'.gopls.setup{}

local nvim_lsp = require('lspconfig')

nvim_lsp.diagnosticls.setup {
    on_attach = on_attach,
    filetypes = { 'javascript', 'javascriptreact', 'json', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'markdown', 'pandoc' },
    init_options = {
        linters = {
            eslint = {
                command = 'eslint_d',
                rootPatterns = { '.git' },
                debounce = 100,
                args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
                sourceName = 'eslint_d',
                parseJson = {
                    errorsRoot = '[0].messages',
                    line = 'line',
                    column = 'column',
                endLine = 'endLine',
            endColumn = 'endColumn',
            message = '[eslint] ${message} [${ruleId}]',
            security = 'severity'
            },
        securities = {
            [2] = 'error',
            [1] = 'warning'
            }
        },
    },
filetypes = {
    javascript = 'eslint',
    javascriptreact = 'eslint',
    typescript = 'eslint',
    typescriptreact = 'eslint',
    },
formatters = {
    eslint_d = {
        command = 'eslint_d',
        args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
        rootPatterns = { '.git' },
        },
    prettier = {
        command = 'prettier',
        args = { '--stdin-filepath', '%filename' }
        }
    },
formatFiletypes = {
    css = 'prettier',
    javascript = 'eslint_d',
    javascriptreact = 'eslint_d',
    json = 'prettier',
    scss = 'prettier',
    less = 'prettier',
    typescript = 'eslint_d',
    typescriptreact = 'eslint_d',
    json = 'prettier',
    markdown = 'prettier',
    }
}
}
-- icon
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    -- This sets the spacing and the prefix, obviously.
    virtual_text = {
        spacing = 4,
        prefix = ''
        }
    }
)

require'nvim-tree'.setup {
    update_focused_file = { enable = true }
    }

EOF


nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>e :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
