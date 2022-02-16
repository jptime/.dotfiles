" Buffers
" nnoremap <leader>bp :bp<CR>
" nnoremap <leader>bn :bn<CR>
"
" " Windows
" nnoremap <leader>wv :vsp<CR>
"
" nnoremap <silent> gh :Lspsaga lsp_finder<CR>
"
" nnoremap <silent><leader>ca :Lspsaga code_action<CR>
" vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
"
" nnoremap <silent>K :Lspsaga hover_doc<CR>
" " scroll down hover doc or scroll in definition preview
" nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
" " scroll up hover doc
" nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
"
"
" " TELESCOPE
" nnoremap <leader>ff <cmd>Telescope find_files<cr>
" nnoremap <leader>sp <cmd>Telescope live_grep<cr>
" nnoremap <leader>si :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
"
" nnoremap <leader>bi <cmd>Telescope buffers<cr>
" nnoremap <leader>fh <cmd>Telescope help_tags<cr>
"
" " Edit
nnoremap <leader>fed :e ~/.config/nvim/init.vim<CR>