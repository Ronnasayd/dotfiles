"  @ vim-airline
if !empty(glob('~/.vim/plugged/vim-airline'))
let g:airline_theme='google_dark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
endif
