"  @ vim-prettier
if !empty(glob('~/.vim/plugged/vim-prettier'))
let g:prettier#autoformat = 1
  let g:prettier#autoformat_require_pragma = 0
  autocmd BufWritePre *.js,*.json,*.css,*.scss,*.less,*.graphql,*.html,*.vue PrettierAsync
endif
