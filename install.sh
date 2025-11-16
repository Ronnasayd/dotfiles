#!/bin/bash
# bash /scripts/build-system.sh
# bash zsh/zsh.install.sh
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

ln -sf  $(pwd)/plank ~/.config/plank
ln -sf  $(pwd)/conky/themes/MyMimosa ~/.config/conky/MyMimosa
ln -sf  $(pwd)/zsh/.zshrc ~/.zshrc
ln -sf  $(pwd)/zsh/.alias.zshrc ~/.alias.zshrc
ln -sf  $(pwd)/zsh/.functions.zshrc ~/.functions.zshrc
ln -sf  $(pwd)/p10k/.p10k.zsh ~/.p10k.zsh
ln -sf  $(pwd)/tmux/.tmux.conf ~/.tmux.conf
ln -sf  $(pwd)/conky/.conkyrc ~/.conkyrc
ln -sf  $(pwd)/terminator/config ~/.config/terminator/config
ln -sf  $(pwd)/vim/.vimrc ~/.vimrc
ln -sf  $(pwd)/vim/.vimrc ~/.config/nvim/init.vim
ln -sf  $(pwd)/vim/vimrc ~/vimrc
ln -sf  $(pwd)/vim/coc-settings.json ~/.vim/coc-settings.json
ln -sf  $(pwd)/vim/coc-settings.json ~/.config/nvim/coc-settings.json
ln -sf  $(pwd)/vim/.coc.vim ~/.coc.vim
ln -sf  $(pwd)/git/.gitconfig ~/.gitconfig
ln -sf  $(pwd)/ulauncher/extensions.json ~/.config/ulauncher/extensions.json
ln -sf  $(pwd)/ulauncher/shortcuts.json ~/.config/ulauncher/shortcuts.json
ln -sf  $(pwd)/ulauncher/settings.json ~/.config/ulauncher/settings.json
ln -sf  $(pwd)/ulauncher/scripts.json ~/.config/ulauncher/scripts.json
ln -sf  $(pwd)/nemo_actions/code_nemo.sh ~/.local/share/nemo/actions/code_nemo.sh
ln -sf  $(pwd)/nemo_actions/code.nemo_action ~/.local/share/nemo/actions/code.nemo_action
ln -sf  $(pwd)/nemo_actions/copy_path_nemo.sh ~/.local/share/nemo/actions/copy_path_nemo.sh
ln -sf  $(pwd)/nemo_actions/copy_path.nemo_action ~/.local/share/nemo/actions/copy_path.nemo_action
ln -sf  $(pwd)/scripts/colorize-logs.sh ~/.local/bin/colorize-logs
ln -sf  $(pwd)/scripts/qr-server.sh ~/.local/bin/qr-server
ln -sf  $(pwd)/scripts/save.sh ~/.local/bin/save
ln -sf  $(pwd)/scripts/qr-copy.sh ~/.local/bin/qr-copy
ln -sf  $(pwd)/scripts/ws.py ~/.local/bin/ws
ln -sf  $(pwd)/scripts/commit_ai.py ~/.local/bin/commitai
ln -sf  $(pwd)/scripts/change_background.sh ~/.local/bin/change_background
ln -sf  $(pwd)/scripts/pscpu.py ~/.local/bin/pscpu
ln -sf  $(pwd)/scripts/create_python_wrapper.sh ~/.local/bin/create_python_wrapper
ln -sf  $(pwd)/scripts/curl_headers.py ~/.local/bin/curl_headers
ln -sf  $(pwd)/plank-links/themes/MyTheme  ~/.local/share/plank/themes/MyTheme
ln -sf  $(pwd)/.editorconfig ~/.editorconfig
ln -sf  $(pwd)/code-themes ~/.vscode/extensions/code-themes
ln -sf  $(pwd)/ssh/config ~/.ssh/config


sudo ln -sf $(pwd)/plank-links/godot.desktop /usr/share/applications/godot.desktop
sudo ln -sf $(pwd)/plank-links/krita.desktop /usr/share/applications/krita.desktop
sudo ln -sf $(pwd)/plank-links/plex.desktop /usr/share/applications/plex.desktop
sudo ln -sf $(pwd)/plank-links/rss.desktop /usr/share/applications/rss.desktop
sudo ln -sf $(pwd)/plank-links/charles.desktop /usr/share/applications/charles.desktop
sudo ln -sf $(pwd)/plank-links/Burp.desktop /usr/share/applications/Burp.desktop



bash ~/.config/conky/MyMimosa/start.sh
