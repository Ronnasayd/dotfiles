 if !empty(glob('~/.coc.vim'))
   source ~/.coc.vim
   let g:coc_global_extensions = [
            \ 'coc-vetur',
            \ 'coc-pyright',
            \ 'coc-tailwindcss',
            \ 'coc-tsserver',
            \ 'coc-json',
            \ ]
   let g:tailwindcss_enable = 1
   let g:tailwindcss_trace_server = 'off'
   let g:tailwindcss_custom_server_path = ''
   let g:tailwindcss_emmet_completions = 1
 endif
