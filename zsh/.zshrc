# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TERM="xterm-256color"
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

export ANDROID_HOME=$HOME/android
export PATH=$ANDROID_HOME/platform-tools/:$PATH
export PATH=$ANDROID_HOME/cmdline-tools/:$PATH
export PATH=$ANDROID_HOME/cmdline-tools/latest/bin/:$PATH

on_enter_directory(){
	if [ -f ".tool-versions" ] && grep -q "go" ".tool-versions"; then
			export GOPATH=$(~/.asdf/shims/go env GOPATH)
	fi
	if [ -f "go.mod" ]; then
			export GO111MODULE=on
	fi
	if [ -f "Gopkg.toml" ]; then
			export GO111MODULE=off
	fi
	if [ -d "venv" ]; then
			deactivate
			source venv/bin/activate
	fi
	SPECIFIC_DIR="/home/ronnas/develop/QQ/"
	CURRENT_DIR="$(pwd)"
	if [[ "$CURRENT_DIR" == "$SPECIFIC_DIR"* ]]; then
	    export GOPRIVATE=github.com/queroquitar/*
	fi
}
on_enter_directory
# this function is called every time a change a directory
function chpwd {
	on_enter_directory
}

rename_all() {
NAME="$1"
NEW_NAME="$2"
fd -t d "$NAME" -exec rename "s/$NAME/$NEW_NAME/" '{}' \;
fd -t f "$NAME" -exec rename "s/$NAME/$NEW_NAME/" '{}' \;
}

git_search_in_branches(){
	git branch | cut -c3- | xargs git grep "$1"
}

code_list_workspaces_date(){
fd -t f  workspace.json ~/.config/Code/User/workspaceStorage | while read line; do
  date=$(stat -c %y $line)
  file=$(jq .folder $line)
  echo "$date $file $line" |  awk '{print $1" "$4" "$5}'
done | sort -k1 | tee /tmp/workspaces.log.txt
}

list_dir_by_date(){
fd -t d  $1 $2 | while read line; do
  date=$(stat -c %y $line)
  echo "$date $line" 
done | sort -k1
}

mkfile() { mkdir -p "$(dirname "$1")" && touch "$1" ;  }

yd:(){
	yarn dev:$1
}
yb:(){
	yarn build:$1
}
yt:(){
	yarn test:$1
}

grep_hnr(){
	grep -HnR  "$1" $2 | awk '{ print substr($0, 1, 130) }'
}


# ALIASES
alias glom="git pull origin master"
alias glod="git pull origin develop"
alias gs="git status"
alias gl="git pull"
alias glo="git pull origin"
alias gcl="git clone"
alias gp="git push"
alias gc="git commit"
alias gb="git branch"
alias gbcd="git branch --sort=-committerdate"
alias gt="git checkout"
alias gtb="git checkout -b "
alias ga="git add"
alias gm="git merge"
alias pyserver="python3 -m http.server 8000 --directory"
alias pyv="python3 -m venv venv"
alias pyv3="virtualenv --python=python3.6 venv"
alias pyv4="virtualenv --python=python2.7 venv"
alias sv="source venv/bin/activate"
alias py="python3"
alias py2="python"
alias dps="docker ps"
alias dpi="docker images"
alias ys="yarn start"
alias yad="yarn add --dev"
alias ya="yarn add"
alias yb="yarn build"
alias yb_="yarn build:"
alias yd="yarn dev"
alias yd_="yarn dev:"
alias yi="yarn init"
alias yil="yarn install"
alias yt="yarn test"
alias yrm="yarn remove"
alias yr="yarn run"
alias co="code"
alias cox="code . && exit"
alias cco="code --disable-extensions --user-data-dir='/tmp/code-user-data-dir' --extensions-dir='/tmp/code-extensions-dir'"
alias _co="sudo code --user-data-dir=~/.vscode-root --no-sandbox"
alias cof="fzf --bind 'enter:become(code {})'"
alias deac="deactivate"
alias pir="pip install -r requirements.txt"
alias gob="go build"
alias gor="go run"
alias gog="go get"
alias tma="tmux attach"
alias tmat="tmux attach -t"
alias tmls="tmux ls"
alias tmd="tmux detach"
alias tmks="tmux kill-server"
alias cpwd="pwd | xclip -selection clipboard"
alias xpwd="terminator --working-directory=$(pwd) -e /bin/zsh &>/dev/null &;disown %1"
alias agdi="ag --path-to-ignore .dockerignore --files-with-matches"
alias aggi="ag --path-to-ignore .gitignore --files-with-matches"
alias kubectl="minikube kubectl --"
alias dsize="du -d 1 -h"
alias chmdn="stat --format '%a'"
alias apt_search="apt-cache search"
alias cpf="copyfile"
alias cplc="fc -ln -1 | xsel --clipboard"
alias json="pp_json"
alias vjson="is_json"
alias alg="alias | grep"
alias q="exit 0"
alias ka="killall"
alias open="xdg-open 2>/dev/null"
alias remove="sudo apt-get autoremove && sudo apt-get autoclean"
alias remove_files="sudo dpkg --purge `dpkg --get-selections | grep deinstall | cut -f1`"
alias curbg="gsettings get org.cinnamon.desktop.background picture-uri"
alias portainer="docker run --rm -d -p 9000:9000 --name portainer  -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer 2>/dev/null; xdg-open http://localhost:9000 2>/dev/null"
alias gports="sudo netstat -tulpn | grep "
alias lports="sudo netstat -tulpn"
alias pkgc="dpkg --list | wc --lines"
alias ffont="fc-list | grep " # find font location
alias lfont="fc-list" # list all fonts
alias stopplex="sudo service plexmediaserver stop"
alias sconky="~/.config/conky/MyMimosa/start.sh"
alias cswap="sudo swapoff -a; sudo swapon -a"
alias limit="ulimit -Sv"
alias fdd="fd -t d"
alias fdf="fd -t f"
alias docker_stop_all="docker ps -aq | xargs docker stop"
alias docker_rm_all="docker ps -aq | xargs docker rm -f"
alias find_node_modules='find . -name "node_modules" -prune -exec sh -c "echo -n \"{}\"; stat -c \" %y\" \"{}\"" \; | awk "{print \$2\" \"\$1}" | sort -k1'
alias watch_cpu='watch -n.1 "grep \"^[c]pu MHz\" /proc/cpuinfo"'

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="t	rue"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git 
	virtualenv
	gitignore 
	gulp 
	extract 
	golang 
	fd 
	urltools
	docker
	docker-compose
	dotenv
	jsontools
	pip
	yarn
	command-not-found
	copyfile
	dirhistory
	history
	jsontools
	dotenv
	tmux
	bgnotify
	colorize
	debian
	wd
	web-search
	python

	asdf 
	zsh-autosuggestions 
	zsh-syntax-highlighting
	alias-tips
)



# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'
ZSH_DOTENV_FILE=.env
ZSH_DOTENV_PROMPT=false
ZSH_TMUX_AUTOSTART_ONCE=true
ZSH_TMUX_CONFIG="$HOME/.tmux.conf"
ZSH_TMUX_UNICODE=true
# ZSH_TMUX_AUTOSTART=true
# ZSH_TMUX_FIXTERM_WITH_256COLOR=true
# ZSH_TMUX_FIXTERM=true

GITSTATUS_LOG_LEVEL=DEBUG



source $ZSH/oh-my-zsh.sh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
export CONDA_AUTO_ACTIVATE_BASE=false
__conda_setup="$('/home/ronnas/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ronnas/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ronnas/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ronnas/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
