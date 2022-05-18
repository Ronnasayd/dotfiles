export TERM="xterm-256color"
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

# ALIASES
alias gs="git status"
alias gl="git pull"
alias gp="git push"
alias gc="git commit"
alias gb="git branch"
alias gt="git checkout"
alias ga="git add"
alias gm="git merge"
alias gpm="git pull origin master"
alias pvv="python3 -m venv venv"
alias pvv36="virtualenv --python=python3.6 venv"
alias pvv27="virtualenv --python=python2.7 venv"
alias dps="docker ps"
alias dpi="docker images"
alias ys="yarn start"
alias ya="yarn add"
alias yad="yarn add --dev"
alias yb="yarn build"
alias yd="yarn dev"
alias yi="yarn init"
alias yins="yarn install"
alias yt="yarn test"
alias yrm="yarn remove"
alias yrun="yarn run"
alias co="code"
alias sac="source venv/bin/activate"
alias deac="deactivate"
alias pipr="pip install -r requirements.txt"
alias cox="code . && exit"
alias gob="go build"
alias gor="go run"
alias tma="tmux attach"
alias tmat="tmux attach -t"
alias tmls="tmux ls"
alias tmd="tmux detach"
alias tmks="tmux kill-server"


function prompt_my_cpu_temp() {
integer cpu_temp=" ($(</sys/class/thermal/thermal_zone0/temp) + $(</sys/class/thermal/thermal_zone1/temp)) / 2000"
if (( cpu_temp >= 80 ));then
	p10k segment -s HOT -f red -i '🔥' -t "${cpu_temp}°C"
elif (( cpu_temp >= 60 ));then
	p10k segment -s WARN -f yellow  -t "${cpu_temp}°C"
else
	p10k segment -s INFO -f green  -t "${cpu_temp}°C"
fi
}

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir vcs virtualenv)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status my_cpu_temp battery ram time)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="╭─"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="╰─⚡️ "
POWERLEVEL9K_RAM_BACKGROUND="#9b6cdd"
POWERLEVEL9K_TIME_BACKGROUND="#7C40DF"
POWERLEVEL9K_TIME_FOREGROUND="#eee"
POWERLEVEL9K_DISK_USAGE_FOREGROUND="#ccc"
POWERLEVEL9K_SHORTEN_DELIMITER=...
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
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
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

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
plugins=(git asdf virtualenv gitignore gulp zsh-autosuggestions tmux)



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

ZSH_TMUX_AUTOSTART=true
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'
ZSH_TMUX_AUTOCONNECT=false
ZSH_TMUX_AUTOQUIT=false

source $ZSH/oh-my-zsh.sh
