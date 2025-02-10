"  @ ctrlp.vim
if !empty(glob('~/.vim/plugged/ctrlp.vim'))
  let g:ctrlp_custom_ignore = '\.node_modules\|\.git\|\.venv\|vendor'
  let g:ctrlp_show_hidden = 1
  let g:ctrlp_user_command = 'fd --type f --hidden --follow --exclude .git'
  let g:ctrlp_use_caching = 0
  let g:ctrlp_map = '<c-p>'
  let g:ctrlp_cmd = 'CtrlP'
endif
