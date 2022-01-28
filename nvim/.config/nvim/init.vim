set encoding=UTF-8
syntax on
set number
set incsearch

set wildmode=longest,list,full
set wildmenu

map <Space> <Leader>

imap jk <Esc>
imap jj <Esc>

" MINI TERMINAL
nnoremap <leader>t :below 10sp term://$SHELL<cr>i

nnoremap <leader>fs :w<CR>

" hit <Escape> key to exit from terminal mode
:tnoremap <Esc> <C-\><C-n>

" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*


" VIM PLUG SETUP
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.vim/plugged')

" LSP Stuff
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'tami5/lspsaga.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"Terminal
Plug 'akinsho/toggleterm.nvim'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'

" Syntax
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'

" Format
Plug 'sbdchd/neoformat'

" LUALINE
Plug 'hoob3rt/lualine.nvim'

Plug 'windwp/windline.nvim'
Plug 'lewis6991/gitsigns.nvim'

" EXPLORER
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" COLORS
Plug 'sainnhe/sonokai'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'embark-theme/vim', { 'as': 'embark' }
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'folke/lsp-colors.nvim'

"VimWiki
Plug 'vimwiki/vimwiki'

"Utils
Plug 'tpope/vim-surround'

Plug 'folke/which-key.nvim'
Plug 'beauwilliams/focus.nvim'

call plug#end()


" Color fix https://thoughtbot.com/blog/modern-typescript-and-react-development-in-vim
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear


colorscheme embark


augroup fmt
    autocmd!
    autocmd BufWritePre * undojoin | Neoformat
augroup END


lua <<EOF
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
        require('luasnip').lsp_expand(args.body)
    end,
    },
mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
        },
    ['<Tab>'] = function(fallback)
    if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
    elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
    else
        fallback()
    end
end,
['<S-Tab>'] = function(fallback)
if vim.fn.pumvisible() == 1 then
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
elseif luasnip.jumpable(-1) then
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
else
    fallback()
end
    end,
    },
sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    },
}

local saga = require 'lspsaga'
saga.init_lsp_saga{
error_sign = '\u{F658}',
warn_sign = '\u{F071}',
hint_sign = '\u{F835}',
}

EOF


