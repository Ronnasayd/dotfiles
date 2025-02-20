"vim-expand-region
if !empty(glob('~/.vim/plugged/vim-expand-region'))
  map <C-Up> <Plug>(expand_region_expand)
  map <C-Down> <Plug>(expand_region_shrink)
  " let g:expand_region_use_select_mode = 1
  let g:expand_region_text_objects = {
      \ 'iw'  :0,
      \ 'iW'  :0,
      \ 'i"'  :0,
      \ 'i''' :0,
      \ 'i]'  :1,
      \ 'ib'  :1,
      \ 'iB'  :1,
      \ 'il'  :1,
      \ 'ip'  :0,
      \ 'ie'  :0,
      \ }
  call expand_region#custom_text_objects({
      \
      \ 'a]' :1,
      \ 'ab' :1,
      \ 'aB' :1,
      \ 'ii' :1,
      \ 'ai' :1,
      \ 'il' :1,
      \ })
endif
