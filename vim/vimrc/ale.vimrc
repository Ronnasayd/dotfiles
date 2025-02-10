"  @ ale
if !empty(glob('~/.vim/plugged/ale'))
  let b:ale_linters = {'javascript': ['eslint'],'python': ['flake8', 'pylint']}
  let g:ale_fixers = {'javascript': ['eslint'],'typescript': ['prettier', 'tslint'],'vue': ['eslint'],'scss': ['prettier'],'html': ['prettier'],'reason': ['refmt']}
  let g:ale_fix_on_save = 1
  let g:ale_linters_explicit = 1
  let g:ale_sign_error = '❌'
  let g:ale_sign_warning = '⚠️'
endif
