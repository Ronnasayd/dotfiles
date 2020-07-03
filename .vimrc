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
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'dense-analysis/ale'
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'Galooshi/vim-import-js'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'wakatime/vim-wakatime'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'alvan/vim-closetag'
Plug 'kendling/taghighlight'
Plug 'chrisbra/Colorizer'
call plug#end()
colorscheme dracula

syntax on

" variables
let g:colorizer_auto_color = 1
let g:airline_theme='dark'
let g:airline_powerline_fonts = 1
let g:rainbow_active = 1
let g:gitgutter_terminal_reports_focus=0
let g:gitgutter_async=0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 20
let g:NERDToggleCheckAllLines = 1
let g:NERDTreeShowHidden=1
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|venv'
let g:ctrlp_show_hidden = 1
let g:javascript_plugin_jsdoc = 1
let g:ycm_autoclose_preview_window_after_completion=1
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.json,*.css,*.scss,*.less,*.graphql PrettierAsync

let b:ale_linters = {'javascript': ['eslint'],'python': ['flake8', 'pylint']}
let g:ale_fixers = {'javascript': ['eslint'],'typescript': ['prettier', 'tslint'],'vue': ['eslint'],'scss': ['prettier'],'html': ['prettier'],'reason': ['refmt']}
let g:ale_fix_on_save = 1
let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}

"map keys
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
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

" Move line
map <Esc>j <A-j>
map <Esc>k <A-k>
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

vnoremap <C-]> >
vnoremap <C-[> <

" Zoom / Restore window (toggle maximize split windos <Alt>x).
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
	execute t:zoom_winrestcmd
	let t:zoomed = 0
    else
	let t:zoom_winrestcmd = winrestcmd()
	resize
	vertical resize
	let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Esc>x :ZoomToggle<CR>

set number
set termguicolors
set encoding=utf8
"set cursorline " diable because is slow down vim
set lazyredraw
set synmaxcol=128
syntax sync minlines=256
set ttyfast
set ttyscroll=3
set autoindent


" Css Autocomplete <C-w><C-o>
filetype plugin on
set omnifunc=syntaxcomplete#Complete 

" Use search silverlight
if executable('ag')
  let g:ackprg = 'ag --hidden  --vimgrep'
endif

" NOTES

" Install font FiraCode
"
" To install youcompleteme

" apt install build-essential cmake vim python3-dev
" :PlugInstall
" cd ~/.vim/plugged/YouCompleteMe
" python3 python3 install.py --all
"
"
"Print key codes to vim
"sed -n l

" Vim import js
" npm install -g import-js
" usage: \j or \i
