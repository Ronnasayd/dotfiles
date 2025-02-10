"@@ NERDTREE
if !empty(glob('~/.vim/plugged/nerdtree'))
"  @ variables
let g:NERDTreeHighlightCursorline=0
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
