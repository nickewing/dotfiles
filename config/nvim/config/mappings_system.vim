function! SystemPaste()
	set paste
  execute "normal! a\<C-R>+"
	set nopaste
endfunction

" Cut
vmap <C-S-x> "+x

" Copy
vmap <C-S-y> "+y

" Paste
nmap <silent> <C-S-v> :call SystemPaste()<CR>
imap <silent> <C-S-v> <ESC>:call SystemPaste()<CR>a
vmap <silent> <C-S-v> c<C-S-v><ESC>
cmap <silent> <C-S-v> <C-R>+<C-L>

" Select all
nmap <C-S-a> ggVG
imap <C-S-a> <ESC>ggVG
vmap <C-S-a> <ESC>ggVG

" Undo
nmap <C-z> u

" Redo
nmap <C-S-z> <C-r>

" Tabs
nmap <silent> <C-S-t> :tabnew<CR>
nmap <silent> <C-Tab> :tabnext<CR>
nmap <silent> <C-S-Tab> :tabprevious<CR>
imap <silent> <C-S-t> <ESC>:tabnew<CR>
imap <silent> <C-Tab> <ESC>:tabnext<CR>
imap <silent> <C-S-Tab> <ESC>:tabprevious<CR>
vmap <silent> <C-S-t> <ESC>:tabnew<CR>
vmap <silent> <C-Tab> <ESC>:tabnext<CR>
vmap <silent> <C-S-Tab> <ESC>:tabprevious<CR>

nmap <silent> <M-1> 1gt
nmap <silent> <M-2> 2gt
nmap <silent> <M-3> 3gt
nmap <silent> <M-4> 4gt
nmap <silent> <M-5> 5gt
nmap <silent> <M-6> 6gt
nmap <silent> <M-7> 7gt
nmap <silent> <M-8> 8gt
nmap <silent> <M-9> 9gt
nmap <silent> <M-0> 10gt

imap <silent> <M-1> <ESC>1gt
imap <silent> <M-2> <ESC>2gt
imap <silent> <M-3> <ESC>3gt
imap <silent> <M-4> <ESC>4gt
imap <silent> <M-5> <ESC>5gt
imap <silent> <M-6> <ESC>6gt
imap <silent> <M-7> <ESC>7gt
imap <silent> <M-8> <ESC>8gt
imap <silent> <M-9> <ESC>9gt
imap <silent> <M-0> <ESC>10gt

" Close buffer
nmap <silent> <C-S-w> :q<CR>

" Delete word
imap <C-BS> <C-w>
cmap <C-BS> <C-w>
