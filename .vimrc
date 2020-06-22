call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'frazrepo/vim-rainbow'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'
Plug 'airblade/vim-gitgutter'
call plug#end()

let g:airline_powerline_fonts = 1
let g:airline_theme='light'
let g:rainbow_active = 1
let g:NERDToggleCheckAllLines = 1

map <C-n> :NERDTreeToggle<CR>
map <C-_> : call NERDComment(0,"toggle")<CR>

set number


