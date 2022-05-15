" let g:ale_lint_on_text_changed = "always"
" let g:ale_lint_delay = 500

let g:ale_sign_column_always = 1

let g:ale_sign_error = '⛔︎'
let g:ale_sign_warning = '🡆'

let g:airline#extensions#ale#enabled = 1

let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_echo_msg_format = '%linter% %severity%: [%code%] %s'
