# Remove aliases
unalias gcb
# Custom aliases
alias glom="git pull origin master" # Pull the latest changes from the master branch
alias glod="git pull origin develop" # Pull the latest changes from the develop branch
alias gs="git status" # Show the working tree status
alias gl="git pull" # Pull the latest changes from the current branch's remote
alias glo="git pull origin" # Pull changes from the specified remote (origin)
alias gcl="git clone" # Clone a repository into a new directory
alias gp="git push" # Push local changes to the remote repository
alias gc="git commit" # Record changes to the repository
alias gcm="git commit -m" # Commit with a message
alias gb="git branch --sort=-committerdate" # List branches sorted by last commit date
alias gt="git checkout" # Switch branches or restore working tree files
alias gtb="git checkout -b" # Create a new branch and switch to it
alias ga="git add" # Add file contents to the index (staging area)
alias gm="git merge" # Join two or more development histories together
alias gfur="git fetch --all --prune --tags --prune-tags --progress" # Update list of remote branches
alias pyserver="python3 -m http.server 8000 --directory" # Start a simple HTTP server in a specified directory
alias pyv="python3 -m venv venv && source venv/bin/activate" # Create and activate a Python virtual environment
alias pyv3="virtualenv --python=python3.6 venv" # Create a virtual environment with Python 3.6
alias pyv4="virtualenv --python=python2.7 venv" # Create a virtual environment with Python 2.7
alias sv="source venv/bin/activate" # Activate the virtual environment
alias rv="rm -rf ./venv" # Remove the virtual environment directory
alias deac="deactivate" # Deactivate the current virtual environment
alias pir="pip install -r requirements.txt" # Install packages from requirements.txt
alias pfr="pip freeze > requirements.txt" # Generate requirements.txt file from pip freeze
alias py="python3" # Alias for Python 3 interpreter
alias py2="python" # Alias for Python interpreter (usually Python 2)
alias dps="docker ps" # List running Docker containers
alias dpi="docker images" # List Docker images on the system
alias dsa="docker ps -aq | xargs docker stop" # Stop all running containers
alias dra="docker ps -aq | xargs docker rm -f" # Force remove all containers
alias dco="docker compose" # Alias for docker compose
alias ys="yarn start" # Start the application using Yarn
alias yad="yarn add --dev" # Add a package as a development dependency using Yarn
alias ya="yarn add" # Add a package using Yarn
alias yb="yarn build" # Build the application using Yarn
alias yb_="yarn build:" # Build a specific target using Yarn build prefix
alias yd="yarn dev" # Run development server using Yarn
alias yd_="yarn dev:" # Run a specific development target with Yarn prefix
alias yi="yarn init" # Initialize a new Yarn project
alias yil="yarn install" # Install all dependencies defined in package.json using Yarn
alias yt="yarn test" # Run tests defined in package.json using Yarn
alias yrm="yarn remove" # Remove a package using Yarn
alias yr="yarn run" # Run an arbitrary command defined in package.json using Yarn
alias pnpi="pnpm install" # Install all dependencies defined in package.json using pnpm
alias co="code" # Open Visual Studio Code editor
alias cox="code . && exit" # Open current directory in VS Code and exit terminal
alias cco="code --disable-extensions --user-data-dir='/tmp/code-user-data-dir' --extensions-dir='/tmp/code-extensions-dir'" # Open VS Code without extensions
alias _co="sudo code --user-data-dir=~/.vscode-root --no-sandbox" # Open VS Code with root privileges
alias cof="fzf --bind 'enter:become(code {})'" # Use fzf to select and open files in VS Code
alias gob="go build" # Build Go project
alias gor="go run"  # Run Go project
alias gog="go get"  # Download and install packages
alias tm="tmux"    # Start a new tmux session
alias tms="tmux new-session -s" # Start a new tmux session with a specific name
alias tks="tmux kill-session -t" # Kill a specific tmux session
alias tma="tmux attach"    # Attach to the last tmux session
alias tmat="tmux attach -t" # Attach to a specific tmux session
alias tmls="tmux ls"       # List all tmux sessions
alias tmd="tmux detach"    # Detach from current tmux session
alias tmks="tmux kill-server" # Kill all tmux sessions
alias cpwd="pwd | xclip -selection clipboard" # Copy current working directory to clipboard
alias xpwd="terminator --working-directory=$(pwd) -e /bin/zsh &>/dev/null &;disown %1" # Open Terminator terminal in current directory
alias agdi="ag --path-to-ignore .dockerignore --files-with-matches" # Search for matches ignoring .dockerignore
alias aggi="ag --path-to-ignore .gitignore --files-with-matches" # Search for matches ignoring .gitignore
alias kubectl="minikube kubectl --" # Use minikube's kubectl command
alias dsize="sudo du -d 1 -h" # Display disk usage of current directory in human-readable format
alias chmdn="stat --format '%a'" # Show file permissions in numeric format
alias apt_search="apt-cache search" # Search for packages in APT
alias cpf="copyfile" # Copy file command alias
alias cplc="fc -ln -1 | xsel --clipboard" # Copy last command to clipboard
alias json="pp_json" # Pretty print JSON data
alias vjson="is_json" # Validate if input is valid JSON
alias alg="alias | grep " # Search for specific aliases
alias q="exit 0" # Exit terminal session gracefully
alias ka="killall " # Kill all processes by name
alias open='xdg-open 2>/dev/null' # Open files or URLs with default application
alias rmv='sudo apt-get autoremove && sudo apt-get autoclean' # Clean up unused packages
alias prg='sudo dpkg --purge "dpkg --get-selections | grep deinstall | cut -f1"' # Purge uninstalled packages
alias curbg='gsettings get org.cinnamon.desktop.background picture-uri' # Get current desktop background URI
alias portainer='docker run --rm -d -p 9000:9000 --name portainer -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer; xdg-open http://localhost:9000' # Run Portainer Docker container and open it in browser
alias gports='sudo netstat -tulpn | grep -i' # Check which processes are listening on which ports
alias lports='sudo netstat -tulpn' # List all listening ports
alias pkgc='dpkg --list | wc --lines' # Count installed packages
alias ffont='fc-list | grep -i' # Find font location by name
alias lfont='fc-list' # List all installed fonts
alias sconky='~/.config/conky/MyMimosa/start.sh' # Start Conky configuration script
alias cswap='sudo swapoff -a; sudo swapon -a' # Turn off and then turn on swap space
alias limit='ulimit -Sv' # Set memory limit for processes
alias fdd='fd -t d' # Find directories using fd command
alias fdf='fd -t f' # Find files using fd command
alias fnm='find . -name "node_modules" -prune -exec sh -c "echo -n \"{}\"; stat -c \" %y\" \"{}\"" \; | awk "{print \$2\" \"\$1}" | sort -k1' # Find node_modules directories and display their last modification time
alias wcpu='watch -n.1 "grep \"^[c]pu MHz\" /proc/cpuinfo"' # Monitor CPU frequency changes every second
alias lzsh='cat ~/.alias.zshrc | grep alias' # List all aliases defined in zshrc file
alias helpalias='cat ~/.alias.zshrc | grep alias | grep -i' # Search for specific aliases in zshrc file
alias ximg='xclip -selection clipboard -t image/png -o >' # Copy image from clipboard to specified file
alias ctf='xclip -selection clipboard  -o >' # Copy content from clipboard to file
alias nfr='ffprobe -v error -select_streams v:0 -count_frames -show_entries stream=nb_frames -of default=noprint_wrappers=1:nokey=1' # Count number of frames in video file
alias echc='pactl load-module module-echo-cancel' # Load PulseAudio module for echo cancellation
alias openr="git config --get remote.origin.url | sed s\"/work.//\" | sed  s\"/:/\//\" | sed s\"/git@/https:\/\//\" | sed s\"/\.git//\" | xargs -I{} xdg-open {}" # Open remote repository URL in default browser
alias openrb="openrb" # Open remote repository URL in current branch at browser
alias openj="openj" # Open remote Jira task by branch
alias mkdir='mkdir -p' # Create directory, including parent directories if necessary
alias cat='ccat' # Syntax-highlighted cat command
alias forcefsck='sudo touch /forcefsck' # Force file system check on next boot
alias incognito="google-chrome --incognito" # Open chrome in incognito mode
alias ska=" showkey -a" # Show pressed characters in terminal. Press Ctrl+D to stop
alias rm="trash" # Use trash to prevent permanent exclusion
alias rmrf="rm -rf" # Remove files and directories recursively
alias las="la -S" # List files by size
alias hsf="history | fzf" # Search history with fzf
alias psf="printenv | fzf" # Search printenv with fzf
alias dcob="docker-compose-build" # Build Docker containers using a specified Docker Compose file: dcob <docker_compose_file>
alias dcou="docker-compose-up" # Start Docker containers using a specified Docker Compose file: dcou <docker_compose_file>
alias renameall="rename-all" # Rename all files and directories matching a given name: renameall <old_name> <new_name>
alias gsib="git-search-pattern-in-branches" # Search for a pattern in all branches of a Git repository: gsib <pattern>
alias clwd="list-code-workspaces-by-date" # List workspaces with their last modified dates
alias ldbd="list-directories-by-date" # List directories sorted by their last modified date: ldbd <pattern> <path>
alias mkfile="make-file" # Create a file and its parent directories if they do not exist: mkfile <file_path>
alias ftext="find-text" # Search for text in files and display matching lines with context: ftext <search_text> <?directory>
alias fdirr="find-directory" # Find directories by name and display their last modified dates: fdirr <directory_name>
alias v2f="video2frames" # Convert a video file into a series of PNG images: v2f <video_path>
alias f2v="frames2video" # Create a video file from a series of PNG images: f2v <output_video_filename> <frames_per_second>
alias cutvideo="cut-video" # Cut a segment from a video file using ffmpeg: cutvideo <input_filename> <start_time> <duration> <output_filename>
alias gfps="get-fps" # Calculate and round the average frame rate of a video file: gfps <video_file>
alias m3ud="m3u-download" # Download a video stream from an .m3u8 playlist file using ffmpeg: m3ud <m3u8_url> <output_filename>
alias pifi="pip-install-break" # Install Python packages using pip3 with system package break handling: pifi <package_names>
alias cwe="copy-with-exclusion" # Copies files from a source directory to a destination directory while excluding specified directories from the copy process: cwe <source_dir> <dest_dir> <exclude_dirs>
alias pc="print-colors" # Display a list of ANSI colors with their corresponding codes.
alias rc="remove-colors" # Remove color codes from text.
alias clogs="colorize-logs" # Colorize log messages based on a specified delimiter: clogs <delimiter>
alias proxy-chrome="google-chrome -proxy-server=http://127.0.0.1:8888 --ignore-certificate-errors --disable-web-security --user-data-dir=~/proxy-chrome-data-dir" # Start Google Chrome with a proxy server and some insecure options
alias insecure-chrome="google-chrome --ignore-certificate-errors --disable-web-security --user-data-dir=~/proxy-chrome-data-dir" # Start Google Chrome with some insecure options
alias zipe='git archive --format=zip -o output.zip HEAD ":(exclude).gitignore"' # Zip archive with git a exclude files at .gitignore
alias xwhats='echo "https://api.whatsapp.com/send?text=$(xclip -o -selection clipboard)" | xclip -selection clipboard' # Transform clipboard content link to WhatsApp message link
alias m="make" # Alias to make command
alias asdfls="asdf list" # List installed plugins. Optionally show git urls and git-ref
alias asdfla="asdf lista all" # List plugins registered on asdf-plugins repository with URLs
alias asdfi="asdf install" # Install a specific version of a package
alias asdflc="asdf local" # Set the package local version
alias asdfg="asdf global" # Set the package global version
alias asdfre="asdf reshim" # Recreate shims for version of a package
alias psmem="sudo ps_mem" # Display processes sorted by memory usage
alias _vi="sudo -E vim" # Open vi with root privileges
alias _vim="sudo -E vim" # Open vi with root privileges
