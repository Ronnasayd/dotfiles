"  @ vim-indent-guides
if !empty(glob('~/.vim/plugged/vim-indent-guides'))
set ts=1 sw=2 et
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level=2
let g:indent_guides_color_change_percent = 20
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#3d4150  ctermbg=3
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#757c9a ctermbg=4
endif
