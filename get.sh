cp ~/.zshrc $(pwd)/zsh/.zshrc
cp ~/.vimrc $(pwd)/vim/.vimrc
cp ~/.p10k.zsh $(pwd)/p10k/.p10k.zsh
cp ~/.tmux.conf $(pwd)/tmux/.tmux.conf
cp ~/.conkyrc $(pwd)/conky/.conkyrc
cp ~/.config/terminator/config $(pwd)/terminator/config
cp ~/.vim/coc-settings.json $(pwd)/vim/coc-settings.json
cp ~/.coc.vim $(pwd)/vim/.coc.vim
cp ~/.gitconfig $(pwd)/git/.gitconfig
dconf dump / > $(pwd)/gnome/dconf.gnome.bkp
# copy mymimosa
cp -r ~/.config/conky/MyMimosa/ $(pwd)/conky/themes/MyMimosa

