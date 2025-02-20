"vim-bookmarks
if !empty(glob('~/.vim/plugged/vim-bookmarks'))
  nnoremap <C-k> :BookmarkToggle<CR>
  nnoremap <C-l> :BookmarkNext<CR>
  nnoremap <C-j> :BookmarkPrev<CR>
  nnoremap <C-i> :BookmarkClearAll<CR>
  nnoremap <C-o> :BookmarkShowAll<CR>
endif
