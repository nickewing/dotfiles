let g:enable_color_column=0
let g:draw_past_color_column=1

" Draw line to indicate max file width
function! s:SetColorColumn()
  if &textwidth != 0
    execute "set colorcolumn=" . (&textwidth + 1)

    if g:draw_past_color_column
      execute "let &colorcolumn=join(range(" . (&textwidth + 1) . ",999),\",\")"
    endif
  endif
endfunction

if g:enable_color_column
  augroup colorcolumn
    autocmd!
    autocmd OptionSet textwidth call s:SetColorColumn()
    autocmd BufEnter * call s:SetColorColumn()
  augroup end
endif


highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)
