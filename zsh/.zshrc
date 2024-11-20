# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TERM="xterm-256color"
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
# export PATH=$ASDF_DIR/shims:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export EDITOR=/usr/bin/code
export VISUAL=/usr/bin/code

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
			export GOPATH=$(~/.asdf/shims/go env GOPATH)
	fi
	if [ -f "Gopkg.toml" ]; then
			export GO111MODULE=off
			export GOPATH=$(~/.asdf/shims/go env GOPATH)
	fi
	if [ -d "venv" ]; then
			source venv/bin/activate
	fi
	SPECIFIC_DIR="/home/ronnas/develop/QQ/"
	QQ_DIR="$(~/.asdf/shims/go env GOPATH)/src/github.com/queroquitar/"
	CURRENT_DIR="$(pwd)"
	if [[ "$CURRENT_DIR" == "$SPECIFIC_DIR"* ]] || [[ "$CURRENT_DIR" == "$QQ_DIR"* ]]; then
    export GOPRIVATE=github.com/queroquitar/*
	fi
}

function recursive_on_enter_directory(){
	d=$(pwd)
	while [ "$(pwd)" != "/" ]; do
		on_enter_directory
		cd ..
	done
	cd "$d"
}

recursive_on_enter_directory
# this function is called every time a change a directory
function chpwd {
	on_enter_directory
}

renameall() {
NAME="$1"
NEW_NAME="$2"
fd -t d "$NAME" -exec rename "s/$NAME/$NEW_NAME/" '{}' \;
fd -t f "$NAME" -exec rename "s/$NAME/$NEW_NAME/" '{}' \;
}

git-search-in-branches(){
	git branch | cut -c3- | xargs git grep "$1"
}

code-list-workspaces-date(){
fd -t f  workspace.json ~/.config/Code/User/workspaceStorage | while read line; do
  date=$(stat -c %y $line)
  file=$(jq .folder $line)
  echo "$date $file $line" |  awk '{print $1" "$4" "$5}'
done | sort -k1 | tee /tmp/workspaces.log.txt
}

list-dir-by-date(){
fd -t d  $1 $2 | while read line; do
  date=$(stat -c %y $line)
  echo "$date $line" 
done | sort -k1 | awk '{print "\033[32m"$1"\033[33m "$2"\033[34m "$3"\033[37m "$4"\033[0m" }'
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

ftext(){
	# $1 = text to search
	# $2 = locate to search
	grep --color=always -HnRE  "$1" $2 | awk '{ print substr($0, 1, length($0) < 250 ? length($0) : 250) }'
}

fdirr(){
	find . -name "$1" -prune -exec sh -c "echo -n \"{}\"; stat -c \" %y\" \"{}\"" \; | awk "{print \$2\" \"\$1}" | sort -k1
}

video2frames(){
	# $1 = video path
	ffmpeg -i $1 %010d.png
}
frames2video(){
	# $1 = video filename
	# $2 = fps
	ffmpeg -r $2 -f image2 -pattern_type glob -i "*.png" -vcodec libx264 -crf 20 -pix_fmt yuv420p $1
}

cutvideo(){
	# $1 = filename
	# $2 = initial time
	# $3 = duration time
	# $4 = output name
	echo "ffmpeg -hide_banner -i $1 -ss $2 -t $3 -c copy  $4.mp4"
	ffmpeg -hide_banner -i $1 -ss $2 -t $3 -c copy  $4.mp4
}

fps(){
	fraction=$(ffprobe -v error -select_streams v:0 -show_entries stream=avg_frame_rate -of default=nw=1:nk=1 $1)
	python -c "print(round(${fraction}))"
}
m3u8-download(){
	# $1 = url of .m3u8 file
	# $2 = output filename
	ffmpeg -i "$1" -c copy -bsf:a aac_adtstoasc $2
}
print-colors(){
	for i in {0..7}; do  
		echo -e "\e[3${i}m ${i} Color: '\\\033[3${i}m' \e[0m"
	done
}



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
ENABLE_CORRECTION="true"

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

# Remove aliases
unalias gcb

# Custom aliases
alias glom="git pull origin master"  # Pull the latest changes from the master branch
alias glod="git pull origin develop"  # Pull the latest changes from the develop branch
alias gs="git status"  # Show the working tree status
alias gl="git pull"  # Pull the latest changes from the current branch's remote
alias glo="git pull origin"  # Pull changes from the specified remote (origin)
alias gcl="git clone"  # Clone a repository into a new directory
alias gp="git push"  # Push local changes to the remote repository
alias gc="git commit"  # Record changes to the repository
alias gcm="git commit -m"  # Commit with a message
alias gb="git branch --sort=-committerdate"  # List branches sorted by last commit date
alias gt="git checkout"  # Switch branches or restore working tree files
alias gtb="git checkout -b"  # Create a new branch and switch to it
alias ga="git add"  # Add file contents to the index (staging area)
alias gm="git merge"  # Join two or more development histories together
alias pyserver="python3 -m http.server 8000 --directory"  # Start a simple HTTP server in a specified directory
alias pyv="python3 -m venv venv && source venv/bin/activate"  # Create and activate a Python virtual environment
alias pyv3="virtualenv --python=python3.6 venv"  # Create a virtual environment with Python 3.6
alias pyv4="virtualenv --python=python2.7 venv"  # Create a virtual environment with Python 2.7
alias sv="source venv/bin/activate"  # Activate the virtual environment
alias rv="rm -rf ./venv"  # Remove the virtual environment directory
alias deac="deactivate"  # Deactivate the current virtual environment
alias pir="pip install -r requirements.txt"  # Install packages from requirements.txt
alias py="python3"  # Alias for Python 3 interpreter
alias py2="python"  # Alias for Python interpreter (usually Python 2)
alias dps="docker ps"  # List running Docker containers
alias dpi="docker images"  # List Docker images on the system
alias dsa="docker ps -aq | xargs docker stop"  # Stop all running containers
alias dra="docker ps -aq | xargs docker rm -f"  # Force remove all containers
alias dco="docker compose" # Alias for docker compose
alias ys="yarn start"  # Start the application using Yarn
alias yad="yarn add --dev"  # Add a package as a development dependency using Yarn
alias ya="yarn add"  # Add a package using Yarn
alias yb="yarn build"  # Build the application using Yarn
alias yb_="yarn build:"  # Build a specific target using Yarn build prefix
alias yd="yarn dev"  # Run development server using Yarn
alias yd_="yarn dev:"  # Run a specific development target with Yarn prefix
alias yi="yarn init"  # Initialize a new Yarn project
alias yil="yarn install"  # Install all dependencies defined in package.json using Yarn
alias yt="yarn test"  # Run tests defined in package.json using Yarn
alias yrm="yarn remove"  # Remove a package using Yarn
alias yr="yarn run"  # Run an arbitrary command defined in package.json using Yarn
alias co="code"  # Open Visual Studio Code editor 
alias cox="code . && exit"  # Open current directory in VS Code and exit terminal 
alias cco="code --disable-extensions --user-data-dir='/tmp/code-user-data-dir' --extensions-dir='/tmp/code-extensions-dir'"  # Open VS Code without extensions 
alias _co="sudo code --user-data-dir=~/.vscode-root --no-sandbox"  # Open VS Code with root privileges 
alias cof="fzf --bind 'enter:become(code {})'"  # Use fzf to select and open files in VS Code
alias gob="go build"   # Build Go project 
alias gor="go run"     # Run Go project 
alias gog="go get"     # Download and install packages 
alias tma="tmux attach"       # Attach to the last tmux session 
alias tmat="tmux attach -t"   # Attach to a specific tmux session 
alias tmls="tmux ls"          # List all tmux sessions 
alias tmd="tmux detach"       # Detach from current tmux session 
alias tmks="tmux kill-server" # Kill all tmux sessions 
alias cpwd="pwd | xclip -selection clipboard"   # Copy current working directory to clipboard 
alias xpwd="terminator --working-directory=$(pwd) -e /bin/zsh &>/dev/null &;disown %1"   # Open Terminator terminal in current directory 
alias agdi="ag --path-to-ignore .dockerignore --files-with-matches"   # Search for matches ignoring .dockerignore 
alias aggi="ag --path-to-ignore .gitignore --files-with-matches"   # Search for matches ignoring .gitignore 
alias kubectl="minikube kubectl --"   # Use minikube's kubectl command 
alias dsize="sudo du -d 1 -h"   # Display disk usage of current directory in human-readable format 
alias chmdn="stat --format '%a'"   # Show file permissions in numeric format 
alias apt_search="apt-cache search"   # Search for packages in APT 
alias cpf="copyfile"   # Copy file command alias 
alias cplc="fc -ln -1 | xsel --clipboard"   # Copy last command to clipboard 
alias json="pp_json"    # Pretty print JSON data 
alias vjson="is_json"    # Validate if input is valid JSON 
alias alg="alias | grep "   # Search for specific aliases  
alias q="exit 0"    # Exit terminal session gracefully  
alias ka="killall "    # Kill all processes by name  
alias open='xdg-open 2>/dev/null'    # Open files or URLs with default application  
alias rmv='sudo apt-get autoremove && sudo apt-get autoclean'    # Clean up unused packages  
alias prg='sudo dpkg --purge "dpkg --get-selections | grep deinstall | cut -f1"'    # Purge uninstalled packages  
alias curbg='gsettings get org.cinnamon.desktop.background picture-uri'    # Get current desktop background URI  
alias portainer='docker run --rm -d -p 9000:9000 --name portainer -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer; xdg-open http://localhost:9000'   # Run Portainer Docker container and open it in browser  
alias gports='sudo netstat -tulpn | grep '   # Check which processes are listening on which ports  
alias lports='sudo netstat -tulpn'   # List all listening ports   
alias pkgc='dpkg --list | wc --lines'   # Count installed packages  
alias ffont='fc-list | grep '   # Find font location by name  
alias lfont='fc-list'   # List all installed fonts  
alias sconky='~/.config/conky/MyMimosa/start.sh'   # Start Conky configuration script  
alias cswap='sudo swapoff -a; sudo swapon -a'   # Turn off and then turn on swap space  
alias limit='ulimit -Sv'   # Set memory limit for processes  
alias fdd='fd -t d'   # Find directories using fd command  
alias fdf='fd -t f'   # Find files using fd command  
alias fnm='find . -name "node_modules" -prune -exec sh -c "echo -n \"{}\"; stat -c \" %y\" \"{}\"" \; | awk "{print \$2\" \"\$1}" | sort -k1'   # Find node_modules directories and display their last modification time  
alias wcpu='watch -n.1 "grep \"^[c]pu MHz\" /proc/cpuinfo"'   # Monitor CPU frequency changes every second  
alias zshal='cat ~/.zshrc | grep alias'   # List all aliases defined in zshrc file  
alias gzsh='cat ~/.zshrc | grep alias | grep '   # Search for specific aliases in zshrc file  
alias ximg='xclip -selection clipboard -t image/png -o > '   # Copy image from clipboard to specified file  
alias nfr='ffprobe -v error -select_streams v:0 -count_frames -show_entries stream=nb_frames -of default=noprint_wrappers=1:nokey=1'   # Count number of frames in video file  
alias echc='pactl load-module module-echo-cancel'   # Load PulseAudio module for echo cancellation  
alias openr="git config --get remote.origin.url | sed s\"/work.//\" | sed  s\"/:/\//\" | sed s\"/git@/https:\/\//\" | xargs -I{} xdg-open {}"   # Open remote repository URL in default browser   
alias mkdir='mkdir -p'    # Create directory, including parent directories if necessary   
alias forcefsck='sudo touch /forcefsck'    # Force file system check on next boot   
alias incognito="google-chrome --incognito"   # Open chrome in incognito mode
alias ska=" showkey -a"   # Show pressed characters in terminal. Press Ctrl+D to stop
alias rmrf="rm -rf"  # Remove files and directories recursively
alias las="la -S"  # List files by size

# pnpm
export PNPM_HOME="/home/ronnas/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
