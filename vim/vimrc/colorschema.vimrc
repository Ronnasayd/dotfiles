"dracula
if !empty(glob('~/.vim/plugged/dracula'))
  let g:dracula_colorterm = 0
  let g:dracula_italic = 0
  set background=dark
endif

"moonlight
if !empty(glob('~/.vim/plugged/moonlight.vim'))
  set background=dark
endif

"kanagawa
if !empty(glob('~/.vim/plugged/kanagawa.vim'))
  set background=dark
endif

"tokyonight
if !empty(glob('~/.vim/plugged/tokyonight.vim'))
  set background=dark
endif



syntax enable
colorscheme moonlight
