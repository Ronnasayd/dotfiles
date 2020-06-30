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
Plug 'ryanoasis/vim-devicons'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
call plug#end()

colorscheme dracula
syntax enable

" variables
let g:airline_theme='light'
let g:airline_powerline_fonts = 1
let g:rainbow_active = 1
let g:gitgutter_terminal_reports_focus=0
let g:gitgutter_async=0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 20
let g:NERDToggleCheckAllLines = 1
let g:NERDTreeShowHidden=1
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git|venv'

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
map <C-k> <C-w><Up>
map <C-Down> <C-w><Down>
map <C-j> <C-w><Down>
map <C-Right> <C-w><Right>
map <C-l> <C-w><Right>
map <C-Left> <C-w><Left>
map <C-h> <C-w><Left>
map <C-a> :Ack! 

map <Esc>j <A-j>
map <Esc>k <A-k>
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

set number
set termguicolors
set encoding=utf8

if executable('ag')
  let g:ackprg = 'ag --hidden  --vimgrep'
endif

" NOTES
"
" Install font FiraCode
"
" to install youcompleteme

" apt install build-essential cmake vim python3-dev
" :PlugInstall
" cd ~/.vim/plugged/YouCompleteMe
" python3 python3 install.py --all
"
"
"Print key codes to vim
"sed -n l

