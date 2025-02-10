"  @ emmet-vim
if !empty(glob('~/.vim/plugged/emmet-vim'))
  let g:user_emmet_install_global = 0
  let g:user_emmet_leader_key='<C-m>'
  let g:user_emmet_settings = {
  \  'javascript.jsx' : {
  \      'extends' : 'jsx',
  \  },
  \}
  autocmd FileType html,css EmmetInstall
endif
