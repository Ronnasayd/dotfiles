sudo apt-get install -y terminator playerctl jq

# install vscode
wget https://vscode.download.prss.microsoft.com/dbazure/download/stable/384ff7382de624fb94dbaf6da11977bba1ecd427/code_1.94.2-1728494015_amd64.deb -O /tmp/vscode.deb
sudo apt install /tmp/vscode.deb
sudo apt install -y tmux

# install chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/chrome.deb
sudo apt install /tmp/chrome.deb

# install plank
sudo add-apt-repository -y ppa:ricotz/docky
sudo apt-get update
sudo apt-get install -y plank

# install conky
sudo apt install -y conky-all

# install font-manager
sudo add-apt-repository ppa:font-manager/staging
sudo apt-get update
sudo apt install font-manager
