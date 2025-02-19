" @@ install plug-vim
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"  @@ list of plugins
call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula','on': [] } " disabled at moment
Plug 'Brettm12345/moonlight.vim', { 'on': [] } " disabled at moment
Plug 'rebelot/kanagawa.nvim', { 'on': [] } " disabled at moment
Plug 'folke/tokyonight.nvim'
Plug 'tpope/vim-fugitive', { 'on': ['EnableVimFugitive'] }
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', {'branch':'release'}
Plug 'nathanaelkane/vim-indent-guides', { 'on': ['EnableVimIndentGuides'] }
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter', { 'on': ['EnableVimGitgutter'] }
Plug 'preservim/nerdcommenter'
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production','on': ['EnablePrettier'] }
Plug 'editorconfig/editorconfig-vim'
Plug 'dense-analysis/ale', { 'on': ['EnableAle'] }
Plug 'mattn/emmet-vim', { 'on': ['EnableEmmetVim'], 'for': ['html'] }
Plug 'wakatime/vim-wakatime', { 'on': ['EnableWakatime'] }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'chrisbra/Colorizer', { 'on': ['EnableColorizer'], 'for': ['html','css'] }
Plug 'alvan/vim-closetag', { 'on': ['EnableVimClosetag'], 'for': ['html'] }
Plug 'ycm-core/YouCompleteMe', { 'on': ['EnableYouCompleteMe'] }
Plug 'leafgarland/typescript-vim', { 'on': [], 'for':['typescript'] }
Plug 'styled-components/vim-styled-components', { 'branch': 'main', 'on': ['EnableStyledComponents'] }
Plug 'maxmellon/vim-jsx-pretty', { 'on': [], 'for':['jsx'] }
Plug 'pangloss/vim-javascript', { 'on': [], 'for':['javascript'] }
Plug 'sheerun/vim-polyglot', { 'on': ['EnableVimPolyglot'] }
Plug 'ryanoasis/vim-devicons'
Plug 'dstein64/vim-startuptime'
Plug 'rhysd/vim-clang-format', { 'for': ['cpp','c','h','hpp'] }
Plug 'terryma/vim-expand-region'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
call plug#end()
