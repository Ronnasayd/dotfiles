1 - Install zsh

```
sudo apt-get install zsh
```

2 - Make zsh default shell

```
chsh -s $(which zsh)
```

3 - Install oh-my-zsh

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

4 - Set theme to agnoster in "~/.zshrc"

```
ZSH_THEME="agnoster"
```

4.1 Use powerlevel9k if you prefer

```
https://github.com/Powerlevel9k/powerlevel9k
```

4.2 Add right elements

```
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status battery ram time)
```

5 - Install Zinit

```

sh -c "\$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

```

6 - Add plugins after line "### End of Zinit's installer chunk" in ~/.zshrc file

```

zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

```

7 - Add `asdf` and `virtualenv` to plugins if you will use

```

plugins=(git asdf virtualenv)

```

8 - Install k to list files and directories

```

https://github.com/supercrabtree/k

```

9 - set vim as default

```
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
```
