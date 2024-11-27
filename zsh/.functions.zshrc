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


# renameall - Rename all files and directories matching a given name.
#
# Usage: renameall <old_name> <new_name>
#
# Parameters:
#   old_name  - The current name (or part of the name) of files and directories to be renamed.
#   new_name  - The new name to assign to the files and directories.
#
# Description:
#   This function searches for all files and directories that match the specified
#   old name using the `fd` command. It then renames them to the new name using
#   the `rename` command. Both files and directories are processed.
renameall() {
    NAME="$1"
    NEW_NAME="$2"
    
    # Rename directories matching the old name
    fd -t d "$NAME" -exec rename "s/$NAME/$NEW_NAME/" '{}' \;
    
    # Rename files matching the old name
    fd -t f "$NAME" -exec rename "s/$NAME/$NEW_NAME/" '{}' \;
}

# gsib - Search for a pattern in all branches of a Git repository.
#
# Usage: gsib <pattern>
#
# Parameters:
#   pattern - The search term or regular expression to look for in the branches.
#
# Description:
#   This function retrieves all local Git branches and searches for the specified
#   pattern within each branch using `git grep`. The results will show occurrences
#   of the pattern along with the corresponding file names and line numbers.
gsib() {
    git branch | cut -c3- | xargs git grep "$1"
}


# clwd - List workspaces with their last modified dates.
#
# Usage: clwd
#
# Description:
#   This function searches for all `workspace.json` files in the 
#   `~/.config/Code/User/workspaceStorage` directory, retrieves their 
#   last modified date, and extracts the folder information using `jq`. 
#   The results are formatted to show the date, folder name, and file path,
#   sorted by date. The output is also saved to a log file at `/tmp/workspaces.log.txt`.
#
clwd() {
    fd -t f workspace.json ~/.config/Code/User/workspaceStorage | while read line; do
        date=$(stat -c %y "$line")
        file=$(jq .folder "$line")
        echo "$date $file $line" | awk '{print $1" "$4" "$5}'
    done | sort -k1 | tee /tmp/workspaces.log.txt
}


# ldbd - List directories sorted by their last modified date.
#
# Usage: ldbd <pattern> <path>
#
# Parameters:
#   pattern - The pattern to match directory names (can include wildcards).
#   path    - The directory path where the search should be performed.
#
# Description:
#   This function uses `fd` to find directories matching the specified pattern
#   within the given path. For each matching directory, it retrieves the last
#   modified date using `stat` and outputs the date along with the directory name.
#   The results are then sorted by date.
ldbd(){
fd -t d  $1 $2 | while read line; do
  date=$(stat -c %y $line)
  echo "$date $line" 
done | sort -k1 
}

# mkfile - Create a file and its parent directories if they do not exist.
#
# Usage: mkfile <file_path>
#
# Parameters:
#   file_path - The path of the file to create, including any necessary parent directories.
#
# Description:
#   This function creates the specified file at the given path. If the parent
#   directories do not already exist, they will be created using `mkdir -p`.
#   After ensuring that the directory structure is in place, it uses `touch`
#   to create the file or update its timestamp if it already exists.
mkfile() { 
    mkdir -p "$(dirname "$1")" && touch "$1" 
}

# ftext - Search for text in files and display matching lines with context.
#
# Usage: ftext <search_text> <directory>
#
# Parameters:
#   search_text - The text or pattern to search for within the specified files.
#   directory    - The directory or path where the search should be performed.
#
# Description:
#   This function uses `grep` to recursively search for the specified text in
#   the files located in the given directory. It highlights matches and shows
#   the line number of each match. The output is limited to the first 250 characters
#   of each matching line for easier readability.
ftext(){
    grep --color=always -HnRE "$1" "$2" | awk '{ print substr($0, 1, length($0) < 250 ? length($0) : 250) }'
}



# fdirr - Find directories by name and display their last modified dates.
#
# Usage: fdirr <directory_name>
#
# Parameters:
#   directory_name - The name of the directory to search for within the current directory tree.
#
# Description:
#   This function searches for directories with the specified name starting from the
#   current directory. It uses the `find` command to locate directories matching the
#   provided name, retrieves their last modified dates using `stat`, and formats the
#   output to show the modification date followed by the directory path. The results
#   are sorted by date.

fdirr(){
    find . -name "$1" -prune -exec sh -c "echo -n \"{}\"; stat -c \" %y\" \"{}\"" \; | awk "{print \$2\" \"\$1}" | sort -k1
}


# v2f - Convert a video file into a series of PNG images.
#
# Usage: v2f <video_path>
#
# Parameters:
#   video_path - The path to the input video file to be converted into images.
#
# Description:
#   This function uses `ffmpeg` to extract frames from the specified video file
#   and save them as PNG images. The images will be named using a zero-padded
#   numbering format (e.g., `0000000001.png`, `0000000002.png`, etc.).
v2f(){
    # $1 = video path
    ffmpeg -i "$1" %010d.png
}

# f2v - Create a video file from a series of PNG images.
#
# Usage: f2v <output_video_filename> <frames_per_second>
#
# Parameters:
#   output_video_filename - The name of the output video file to be created (with extension).
#   frames_per_second      - The frame rate for the output video.
#
# Description:
#   This function uses `ffmpeg` to compile a series of PNG images into a video file.
#   The images should be named in a way that allows them to be matched by the glob pattern.
#   The output video is encoded using the H.264 codec with a specified frame rate.
f2v(){
    ffmpeg -r "$2" -f image2 -pattern_type glob -i "*.png" -vcodec libx264 -crf 20 -pix_fmt yuv420p "$1"
}

# cutvideo - Cut a segment from a video file using ffmpeg.
#
# Usage: cutvideo <input_filename> <start_time> <duration> <output_filename>
#
# Parameters:
#   input_filename  - The path to the input video file to be cut.
#   start_time      - The starting point of the cut in the format HH:MM:SS or seconds.
#   duration        - The duration of the cut segment in the format HH:MM:SS or seconds.
#   output_filename  - The name for the output video file (without extension).
#
# Description:
#   This function uses `ffmpeg` to extract a segment from a specified video file.
#   It takes the input filename, starting time, and duration of the segment to be
#   extracted, and saves it as a new video file. The output filename is specified
#   without an extension, as the function appends ".mp4" automatically.
#
# Example:
#   cutvideo "input.mp4" "00:01:30" "00:00:10" "output"
#   # This will extract a 10-second segment starting from 1 minute and 30 seconds
#   # into "input.mp4" and save it as "output.mp4".
cutvideo(){
    echo "ffmpeg -hide_banner -i $1 -ss $2 -t $3 -c copy $4.mp4"
    ffmpeg -hide_banner -i "$1" -ss "$2" -t "$3" -c copy "$4.mp4"
}


# fps - Calculate and round the average frame rate of a video file.
#
# Usage: fps <video_file>
#
# Parameters:
#   video_file - The path to the video file for which to calculate the average frame rate.
#
# Description:
#   This function uses `ffprobe` to extract the average frame rate of the specified
#   video file. It retrieves the frame rate as a fraction and then uses Python to
#   round the value to the nearest integer. The rounded frame rate is printed to the
#   standard output.


fps(){
    fraction=$(ffprobe -v error -select_streams v:0 -show_entries stream=avg_frame_rate -of default=nw=1:nk=1 "$1")
    python -c "print(round(${fraction}))"
}

# m3ud - Download a video stream from an .m3u8 playlist file using ffmpeg.
#
# Usage: m3ud <m3u8_url> <output_filename>
#
# Parameters:
#   m3u8_url       - The URL of the .m3u8 file containing the video stream playlist.
#   output_filename - The name of the output file where the downloaded video will be saved.
#
# Description:
#   This function uses `ffmpeg` to download a video stream from a specified .m3u8
#   playlist file. It takes the URL of the .m3u8 file as input and saves the
#   downloaded video to the specified output filename. The audio is processed to
#   ensure compatibility with standard formats.
#
# Example:
#   m3ud "http://example.com/playlist.m3u8" "output.mp4"
#   # This will download the video stream from the specified .m3u8 URL and save
#   # it as "output.mp4".

m3ud(){
    ffmpeg -i "$1" -c copy -bsf:a aac_adtstoasc "$2"
}

# pc - Display a list of ANSI colors with their corresponding codes.
#
# Usage: pc
#
# Description:
#   This function prints out a series of ANSI colors (from 0 to 7) along with
#   their corresponding escape codes. Each color is displayed in its respective
#   color format, allowing users to see how the colors appear in the terminal.

pc(){
    for i in {0..7}; do  
        echo -e "\e[3${i}m ${i} Color: '\\\033[3${i}m' \e[0m"
    done
}

# dcob - Build Docker containers using a specified Docker Compose file.
#
# Usage: dcob <docker_compose_file>
#
# Parameters:
#   docker_compose_file - The path to the Docker Compose file used for building containers.
#
# Description:
#   This function uses `docker compose` to build the services defined in the specified
#   Docker Compose file. It allows users to easily manage container builds without
#   needing to type the full command each time.
#
# Example:
#   dcob "docker-compose.yml"
#   # This will build the containers defined in "docker-compose.yml".

dcob(){
    docker compose -f "$1" build
}

# dcou - Start Docker containers using a specified Docker Compose file.
#
# Usage: dcou <docker_compose_file>
#
# Parameters:
#   docker_compose_file - The path to the Docker Compose file used for starting containers.
#
# Description:
#   This function uses `docker compose` to start the services defined in the specified
#   Docker Compose file. It simplifies the process of launching containers by providing
#   a shorthand command.
#
# Example:
#   dcou "docker-compose.yml"
#   # This will start the containers defined in "docker-compose.yml".

dcou(){
    docker compose -f "$1" up
}

# pifi - Install Python packages using pip3 with system package break handling.
#
# Usage: pifi <packages>
#
# Parameters:
#   packages - A space-separated list of Python packages to install.
#
# Description:
#   This function uses `pip3` to install the specified Python packages. The `--break-system-packages`
#   option allows installation even if it may conflict with system packages, which can be useful
#   in certain environments where package versions need to be overridden.
#
# Example:
#   pifi "numpy pandas"
#   # This will install the packages "numpy" and "pandas" using pip3.

pifi(){
    pip3 install "$1" --break-system-packages
}