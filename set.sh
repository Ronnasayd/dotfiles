cp  $(pwd)/zsh/.zshrc ~/.zshrc
cp  $(pwd)/vim/.vimrc ~/.vimrc
cp  $(pwd)/p10k/.p10k.zsh ~/.p10k.zsh
cp  $(pwd)/tmux/.tmux.conf ~/.tmux.conf
cp  $(pwd)/conky/.conkyrc ~/.conkyrc
cp  $(pwd)/terminator/config ~/.config/terminator/config
cp  $(pwd)/vim/coc-settings.json ~/.vim/coc-settings.json
cp  $(pwd)/vim/.coc.vim ~/.coc.vim
cp  $(pwd)/git/.gitconfig ~/.gitconfig
dconf dump / < $(pwd)/gnome/dconf.gnome.bkp
# copy mymimosa
cp -r  $(pwd)/conky/themes/ ~/.config/conky/MyMimosa/

