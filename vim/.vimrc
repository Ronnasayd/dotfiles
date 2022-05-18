"  @@ install plug-vim 
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"  @@ list of plugins
call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'frazrepo/vim-rainbow'
Plug 'jiangmiao/auto-pairs'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'dense-analysis/ale'
Plug 'mattn/emmet-vim'
Plug 'chrisbra/Colorizer'
Plug 'wakatime/vim-wakatime'
Plug 'alvan/vim-closetag'
Plug 'ycm-core/YouCompleteMe'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'sheerun/vim-polyglot'
Plug 'ryanoasis/vim-devicons'
call plug#end()


"  @@ dracula
if !empty(glob('~/.vim/plugged/dracula'))
  syntax enable
  colorscheme dracula
  "let g:dracula_colorterm = 0
  "let g:dracula_italic = 0
  set background=dark
endif

"  @@ NERDTREE
if !empty(glob('~/.vim/plugged/nerdtree'))
  "  @ variables
  let g:NERDToggleCheckAllLines = 1
  let g:NERDTreeShowHidden=1
  let g:NERDTreeIgnore = ['^node_modules$','^venv$']
  let NERDTreeCustomOpenArgs={'file':{'where': 't'}}
  "let g:NERDTreeMapOpenInTab='<C-ENTER>'
  "  @ <CTRL+n> toggle NERDTree
  map <silent><C-n> :NERDTreeToggle<CR>
  " Start NERDTree when Vim is started without file arguments.
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
endif

"  @ NERDCommenter
if !empty(glob('~/.vim/plugged/nerdcommenter'))
  "  @ <CTRL + /> comment code
  map <silent><C-_> :call NERDComment(0,"toggle")<CR>
endif

"  @ vim-airline
if !empty(glob('~/.vim/plugged/vim-airline'))
  let g:airline_theme='dark'
  let g:airline_powerline_fonts = 1
endif

"  @ vim-rainbow
if !empty(glob('~/.vim/plugged/vim-rainbow'))
  let g:rainbow_active = 1
endif

"  @ vim-indent-guides
if !empty(glob('~/.vim/plugged/vim-indent-guides'))
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_guide_size = 1
  let g:indent_guides_color_change_percent = 20
  let g:indent_guides_auto_colors = 0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#3d4150  ctermbg=3
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#757c9a ctermbg=4
endif

"  @ ctrlp.vim
if !empty(glob('~/.vim/plugged/ctrlp.vim'))
  let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|venv'
  let g:ctrlp_show_hidden = 1
  let g:ctrlp_map = '<c-p>'
  let g:ctrlp_cmd = 'CtrlP'
endif


"  @ vim-gitgutter
if !empty(glob('~/.vim/plugged/vim-gitgutter'))
  let g:gitgutter_terminal_reports_focus=0
  let g:gitgutter_async=0
endif

"  @ vim-prettier
if !empty(glob('~/.vim/plugged/vim-prettier'))
  let g:prettier#autoformat = 1
  autocmd BufWritePre *.js,*.json,*.css,*.scss,*.less,*.graphql PrettierAsync
endif

"  @ ale
if !empty(glob('~/.vim/plugged/ale'))
  let b:ale_linters = {'javascript': ['eslint'],'python': ['flake8', 'pylint']}
  let g:ale_fixers = {'javascript': ['eslint'],'typescript': ['prettier', 'tslint'],'vue': ['eslint'],'scss': ['prettier'],'html': ['prettier'],'reason': ['refmt']}
  let g:ale_fix_on_save = 1
  let g:ale_linters_explicit = 1
  let g:ale_sign_error = '❌'
  let g:ale_sign_warning = '⚠️'
endif

"  @ emmet-vim
if !empty(glob('~/.vim/plugged/emmet-vim'))
  let g:user_emmet_install_global = 0
  let g:user_emmet_leader_key='<Tab>'
  let g:user_emmet_settings = {
  \  'javascript.jsx' : {
  \      'extends' : 'jsx',
  \  },
  \}
  autocmd FileType html,css EmmetInstall
endif

"  @ Colorizer
if !empty(glob('~/.vim/plugged/Colorizer'))
  let g:colorizer_auto_color = 1
endif

"  @ vim-closetag
if !empty(glob('~/.vim/plugged/vim-closetag'))
  let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
  let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
  let g:closetag_filetypes = 'html,xhtml,phtml'
  let g:closetag_xhtml_filetypes = 'xhtml,jsx'
  let g:closetag_emptyTags_caseSensitive = 1
  let g:closetag_shortcut = '>'
  let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }
endif

"  @ vim-devicons
if !empty(glob('~/.vim/plugged/vim-devicons'))
  let g:webdevicons_enable = 1
  let g:webdevicons_enable_nerdtree = 1
  let g:webdevicons_enable_airline_tabline = 1
  let g:webdevicons_enable_airline_statusline = 1
  let g:webdevicons_enable_ctrlp = 1
endif

"  @ YouCompleteMe
if !empty(glob('~/.vim/plugged/YouCompleteMe'))
  "  Execute this commands to compile
  "  >> apt-get install -y make python3-dev build-essential vim-nox
  "  >> python3 ~/.vim/plugged/YouCompleteMe/install.py --all
  let g:ycm_autoclose_preview_window_after_completion=1
  map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
endif

 "  @ vim-javascript
 if !empty(glob('~/.vim/plugged/vim-javascript'))
    let g:javascript_plugin_jsdoc = 1
 endif

"  @ definitions
set number
set mouse=a
set termguicolors
set encoding=utf-8
set fileencoding=utf-8
set lazyredraw
set synmaxcol=80
set ttyfast
set regexpengine=1
set autoindent
syntax on
syntax sync minlines=64
filetype plugin on
"  @ map keys
" <CTRL + c> copy
vmap <C-c> y
" <CTRL + x> cut
vmap <C-x> x
" <CTRL + v> paste
imap <C-v> <esc>P
" <CTRTL + z> undo
nmap <C-z> u
" <SHIFT + e> split horizontal
map <silent><S-e> :vsp<CR>
" <SHIFT + o> split vertical
map <silent><S-o> :sp<CR>
" <CTRL + up> move to up split
map <C-Up> <C-w><Up>
" <CTRL + k> move to up split
map <C-k> <C-w><Up>
" <CTRL + down> move to down split
map <C-Down> <C-w><Down>
" <CTRL + j> move to down split
map <C-j> <C-w><Down>
" <CTRL + right> move to right split
map <C-Right> <C-w><Right>
" <CTRL + l> move to right split
map <C-l> <C-w><Right>
" <CTRL + left> move to left split
map <C-Left> <C-w><Left>
" <CTRL + h> move to left split
map <C-h> <C-w><Left>

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

nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-LeftMouse> <LeftMouse>:YcmCompleter GoTo<CR>
