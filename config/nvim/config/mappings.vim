" Resize windows
map <silent> <C-h> :vertical resize -10<CR>
map <silent> <C-l> :vertical resize +10<CR>
map <silent> <C-j> :resize +10<CR>
map <silent> <C-k> :resize -10<CR>

" Visual shifting
vnoremap < <gv
vnoremap > >gv

" Disable ex mode
map Q <Nop>

" Yank current file path to system buffer
nmap yF :let @+ = expand("%")<CR>


map <leader>wh <C-W>h
map <leader>wj <C-W>j
map <leader>wk <C-W>k
map <leader>wl <C-W>l
map <leader>wc <C-W>c

map <leader>rf :cnf<CR>
map <leader>rn :cn<CR>
map <leader>rp :cp<CR>
map <leader>rc :ccl<CR>
