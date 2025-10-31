# Install base packages
sudo apt-get update
sudo apt-get install -y terminator playerctl jq python3-pip fd-find pavucontrol git-lfs ffmpeg vlc qbittorrent silversearcher-ag neovim trash bat wget xclip

# Install asdf
wget https://github.com/asdf-vm/asdf/releases/download/v0.18.0/asdf-v0.18.0-linux-amd64.tar.gz -O /tmp/asdf.tar.gz
tar -xvzf /tmp/asdf.tar.gz
mv asdf /usr/local/bin/asdf

# Install Docker
bash ./docker.install.sh

# Install yq
wget https://github.com/mikefarah/yq/releases/download/v4.45.4/yq_linux_amd64 -O /usr/local/bin/yq && chmod +x /usr/local/bin/yq

# Install vscode
wget https://vscode.download.prss.microsoft.com/dbazure/download/stable/384ff7382de624fb94dbaf6da11977bba1ecd427/code_1.94.2-1728494015_amd64.deb -O /tmp/vscode.deb
sudo apt install /tmp/vscode.deb

# Install tmux
sudo apt install -y tmux

# Install chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/chrome.deb
sudo apt install /tmp/chrome.deb

# Install plank
sudo add-apt-repository -y ppa:ricotz/docky
sudo apt-get update
sudo apt-get install -y plank

# Install conky
sudo apt install -y conky-all

# Install font-manager
sudo add-apt-repository ppa:font-manager/staging
sudo apt-get update
sudo apt install font-manager

# Install papirus icon theme
sudo add-apt-repository ppa:papirus/papirus
sudo apt-get update
sudo apt-get install papirus-icon-theme  # Papirus, Papirus-Dark, and Papirus-Light
sudo apt-get install epapirus-icon-theme # ePapirus, and ePapirus-Dark for elementaryOS only

# Install ulauncher
sudo add-apt-repository universe -y
sudo add-apt-repository ppa:agornostal/ulauncher -y
sudo apt update && sudo apt install ulauncher

# Install qbittorrent
sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable
sudo apt-get update
sudo apt-get install qbittorrent

# Install bat
mv /usr/bin/batcat /usr/bin/bat

# Install gh cli
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh
