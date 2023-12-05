apt-get update
apt-get install -y curl zsh git

printf 'yes' | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/djui/alias-tips.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/alias-tips

git clone https://github.com/asdf-vm/asdf.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/asdf