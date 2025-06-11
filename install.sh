#!/bin/bash

dconf dump / < $(pwd)/gnome/dconf.gnome.bkp

mkdir -p /tmp/.backup
mv ~/.zshrc /tmp/.backup
mv ~/.alias.zshrc /tmp/.alias.backup
mv ~/.functions.zshrc /tmp/.functions.backup
mv ~/.vimrc /tmp/.backup
mv ~/.p10k.zsh /tmp/.backup
mv ~/.tmux.conf /tmp/.backup
mv ~/.conkyrc /tmp/.backup
mv ~/.config/terminator/config /tmp/.backup
mv ~/.vim/coc-settings.json /tmp/.backup
mv ~/.coc.vim /tmp/.backup
mv ~/.gitconfig /tmp/.backup
mv ~/.config/conky/MyMimosa /tmp/.backup
mv ~/.config/plank /tmp/.backup
mv ~/.config/ulauncher/extensions.json /tmp/.backup
mv ~/.config/ulauncher/shortcuts.json /tmp/.backup
mv  ~/.config/ulauncher/settings.json /tmp/.backup
mv ~/.local/share/nemo/actions/code_nemo.sh /tmp/backup
mv ~/.local/share/nemo/actions/code.nemo_action /tmp/backup
mv ~/.config/ulauncher/scripts.json /tmp/.backup
mv ~/.local/share/plank/themes/MyTheme /tmp/.backup
mv ~/.editorconfig /tmp/backup

ln -s  $(pwd)/plank ~/.config/plank
ln -s  $(pwd)/conky/themes/MyMimosa ~/.config/conky/MyMimosa
ln -s  $(pwd)/zsh/.zshrc ~/.zshrc
ln -s  $(pwd)/zsh/.alias.zshrc ~/.alias.zshrc
ln -s  $(pwd)/zsh/.functions.zshrc ~/.functions.zshrc
ln -s  $(pwd)/p10k/.p10k.zsh ~/.p10k.zsh
ln -s  $(pwd)/tmux/.tmux.conf ~/.tmux.conf
ln -s  $(pwd)/conky/.conkyrc ~/.conkyrc
ln -s  $(pwd)/terminator/config ~/.config/terminator/config
ln -s  $(pwd)/vim/.vimrc ~/.vimrc
ln -s  $(pwd)/vim/.vimrc ~/.config/nvim/init.vim
ln -s  $(pwd)/vim/vimrc ~/vimrc
ln -s  $(pwd)/vim/coc-settings.json ~/.vim/coc-settings.json
ln -s  $(pwd)/vim/coc-settings.json ~/.config/nvim/coc-settings.json
ln -s  $(pwd)/vim/.coc.vim ~/.coc.vim
ln -s  $(pwd)/git/.gitconfig ~/.gitconfig
ln -s  $(pwd)/ulauncher/extensions.json ~/.config/ulauncher/extensions.json
ln -s  $(pwd)/ulauncher/shortcuts.json ~/.config/ulauncher/shortcuts.json
ln -s  $(pwd)/ulauncher/settings.json ~/.config/ulauncher/settings.json
ln -s  $(pwd)/ulauncher/scripts.json ~/.config/ulauncher/scripts.json
ln -s  $(pwd)/nemo_actions/code_nemo.sh ~/.local/share/nemo/actions/code_nemo.sh
ln -s  $(pwd)/nemo_actions/code.nemo_action ~/.local/share/nemo/actions/code.nemo_action
ln -s  $(pwd)/nemo_actions/copy_path_nemo.sh ~/.local/share/nemo/actions/copy_path_nemo.sh
ln -s  $(pwd)/nemo_actions/copy_path.nemo_action ~/.local/share/nemo/actions/copy_path.nemo_action
ln -s  $(pwd)/scripts/colorize-logs.sh ~/.local/bin/colorize-logs
ln -s  $(pwd)/scripts/qr-server.sh ~/.local/bin/qr-server
ln -s  $(pwd)/scripts/qr-copy.sh ~/.local/bin/qr-copy
ln -s  $(pwd)/plank-links/themes/MyTheme  ~/.local/share/plank/themes/MyTheme
ln -s  $(pwd)/.editorconfig ~/.editorconfig
ln -s  $(pwd)/code-themes ~/.vscode/extensions/code-themes


sudo ln -s $(pwd)/plank-links/godot.desktop /usr/share/applications/godot.desktop
sudo ln -s $(pwd)/plank-links/krita.desktop /usr/share/applications/krita.desktop
sudo ln -s $(pwd)/plank-links/plex.desktop /usr/share/applications/plex.desktop
sudo ln -s $(pwd)/plank-links/rss.desktop /usr/share/applications/rss.desktop
sudo ln -s $(pwd)/plank-links/charles.desktop /usr/share/applications/charles.desktop
sudo ln -s $(pwd)/plank-links/Burp.desktop /usr/share/applications/Burp.desktop



bash ~/.config/conky/MyMimosa/start.sh
