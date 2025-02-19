"  @ map keys
" <CTRL + c> copy
vmap <C-c> "+y
nmap <C-c> "+yy
" <CTRL + x> cut
vmap <C-x> x
nmap <C-x> "+yy dd
" <CTRL + v> paste
imap <C-v> <esc>P
nmap <C-v> <esc>P
" <CTRTL + z> undo
nmap <C-z> u
" <SHIFT + e> split horizontal
map <silent><S-e> :vsp<CR>
" <SHIFT + o> split vertical
map <silent><S-o> :sp<CR>
" <SHIFT + up> move to up split
map <S-Up> <C-w><Up>
" <SHIFT + k> move to up split
map <S-k> <C-w><Up>
" <SHIFT + down> move to down split
map <S-Down> <C-w><Down>
" <SHIFT + j> move to down split
map <S-j> <C-w><Down>
" <SHIFT + right> move to right split
map <S-Right> <C-w><Right>
" <SHIFT + l> move to right split
map <S-l> <C-w><Right>
" <SHIFT + left> move to left split
map <S-Left> <C-w><Left>
" <SHIFT + h> move to left split
map <S-h> <C-w><Left>

noremap <C-s> :w<CR>
noremap <C-w> :q<CR>

" Move line
map <Esc>j <A-j>
map <Esc>k <A-k>
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

noremap <C-a> <Esc>ggVG
noremap <S-a> Vat

nnoremap <S-n> :new<CR>
nnoremap <S-Tab> :tabnext<CR>

nnoremap <C-Left> b
nnoremap <C-Right> w


vnoremap <S-Left> 0
vnoremap <S-Right> $

map <F12> gd
map <F10> gr
map <F9> gi
map <F8> gy


map <C-Up> <Plug>(expand_region_expand)
map <C-Down> <Plug>(expand_region_shrink)

