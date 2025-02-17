" @ NERDCommenter
if !empty(glob('~/.vim/plugged/nerdcommenter'))
" @ <CTRL + /> comment code
map <silent><C-_> :call nerdcommenter#Comment(0,"toggle")<CR>
endif
