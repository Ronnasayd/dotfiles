if !empty(glob('~/.vim/plugged/YouCompleteMe'))
"  @ YouCompleteMe
  "  Execute this commands to compile
  "  >> apt-get install -y make python3-dev build-essential vim-nox
  "  >> python3 ~/.vim/plugged/YouCompleteMe/install.py --all
  let g:ycm_autoclose_preview_window_after_completion=1
  let g:ycm_goto_buffer_command = 'new-tab'
  nnoremap <C-LeftMouse> <LeftMouse>:YcmCompleter GoTo<CR>
  map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
endif
