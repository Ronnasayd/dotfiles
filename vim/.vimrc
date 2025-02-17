
source ~/vimrc/vim-plugin.vimrc
source ~/vimrc/colorschema.vimrc
source ~/vimrc/nerdtree.vimrc
source ~/vimrc/nerdcommenter.vimrc
source ~/vimrc/vim-airline.vimrc
source ~/vimrc/vim-indent-guides.vimrc
source ~/vimrc/ctrlp.vimrc
source ~/vimrc/vim-gitgutter.vimrc
source ~/vimrc/vim-prettier.vimrc
source ~/vimrc/ale.vimrc
source ~/vimrc/emmet-vim.vimrc
source ~/vimrc/colorizer.vimrc
source ~/vimrc/vim-closetag.vimrc
source ~/vimrc/vim-devicons.vimrc
source ~/vimrc/youcompleteme.vimrc
source ~/vimrc/vim-javascript.vimrc
source ~/vimrc/coc.vimrc
source ~/vimrc/map-keys.vimrc

"@ definitions
set re=1
set foldmethod=marker
"set nocursorline
"set nocursorcolumn
set number
set nocompatible
set mouse=a
set encoding=utf-8
set fileencoding=utf-8
set lazyredraw
set background=dark
set termguicolors
"set synmaxcol=100
set ttyfast
set regexpengine=1
set autoindent
set guifont=JetBrainsMono\ Nerd\ Font\ Mono\ Regular\ 12
syntax on
syntax sync minlines=64
filetype plugin on
let g:vue_disable_pre_processors=1
hi Normal guibg=NONE ctermbg=NONE " make vim terminal transparent

command! Q :q
command! W :w
command! Wq :wq
command! WQ :wq

cabbrev marketplace CocList marketplace


