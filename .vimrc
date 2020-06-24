call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'frazrepo/vim-rainbow'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'
Plug 'mileszs/ack.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ycm-core/YouCompleteMe'
call plug#end()

colorscheme dracula
syntax enable

" variables
let g:airline_powerline_fonts = 1
let g:airline_theme='light'
let g:rainbow_active = 1
let g:NERDToggleCheckAllLines = 1
let g:gitgutter_terminal_reports_focus=0
let g:gitgutter_async=0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 3

"map keys
map <silent><C-n> :NERDTreeToggle<CR>
map <silent><C-_> :call NERDComment(0,"toggle")<CR>
map <silent><S-e> :vsp<CR>
map <silent><S-o> :sp<CR>
vmap <C-c> y
vmap <C-x> x
imap <C-v> <esc>P
nmap <C-z> u
map <C-Up> <C-w><Up>
map <C-Down> <C-w><Down>
map <C-Right> <C-w><Right>
map <C-Left> <C-w><Left>


set number
set termguicolors

" Notes
" to install youcompleteme
" apt install build-essential cmake vim python3-dev
" :PlugInstall
" cd ~/.vim/plugged/YouCompleteMe
" python3 python3 install.py --all
