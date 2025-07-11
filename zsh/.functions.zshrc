on_enter_directory() {
  if [[ -f "$1/.tool-versions" && $(<$1/.tool-versions) == *go* ]]; then
    export GOPATH=$(~/.asdf/shims/go env GOPATH)
  fi
  if [ -f "$1/go.mod" ]; then
    export GO111MODULE=on
    export GOPATH=$(~/.asdf/shims/go env GOPATH)
  fi
  if [ -f "$1/Gopkg.toml" ]; then
    export GO111MODULE=off
    export GOPATH=$(~/.asdf/shims/go env GOPATH)
  fi
  if [ -d "$1/venv" ]; then
    source "$1/venv/bin/activate"
  fi
  SPECIFIC_DIR="/home/ronnas/develop/QQ/"
  QQ_DIR="$(~/.asdf/shims/go env GOPATH)/src/github.com/queroquitar/"
  CURRENT_DIR="$(pwd)"
  if [[ "$CURRENT_DIR" == "$SPECIFIC_DIR"* ]] || [[ "$CURRENT_DIR" == "$QQ_DIR"* ]]; then
    export GOPRIVATE=github.com/queroquitar/*
  fi
}

function recursively_on_enter_directory() {
  local RPATH
  RPATH=$(pwd)
  while [[ "$RPATH" != "/" && "$RPATH" != "" ]]; do
    if [[ -f "$RPATH/.tool-versions" || -f "$RPATH/go.mod" || -f "$RPATH/Gopkg.toml" || -d "$RPATH/venv" ]]; then
      # echo "$RPATH"
      on_enter_directory $RPATH
      break
    fi
    RPATH="${RPATH%/*}"
  done

}

recursively_on_enter_directory
# this function is called every time a change a directory
function chpwd {
  local RPATH=$(pwd)
  on_enter_directory $RPATH
}

# rename-all - Rename all files and directories matching a given name.
#
# Usage: rename-all <old_name> <new_name>
#
# Parameters:
#   old_name  - The current name (or part of the name) of files and directories to be renamed.
#   new_name  - The new name to assign to the files and directories.
#
# Description:
#   This function searches for all files and directories that match the specified
#   old name using the `fd` command. It then renames them to the new name using
#   the `rename` command. Both files and directories are processed.
rename-all() {
  NAME="$1"
  NEW_NAME="$2"

  # Rename directories matching the old name
  fd -t d "$NAME" | xargs -I{} -exec rename "s/$NAME/$NEW_NAME/" '{}' \;

  # Rename files matching the old name
  fd -t f "$NAME" | xargs -I{} -exec rename "s/$NAME/$NEW_NAME/" '{}' \;
}

# git-search-pattern-in-branches - Search for a pattern in all branches of a Git repository.
#
# Usage: git-search-pattern-in-branches <pattern>
#
# Parameters:
#   pattern - The search term or regular expression to look for in the branches.
#
# Description:
#   This function retrieves all local Git branches and searches for the specified
#   pattern within each branch using `git grep`. The results will show occurrences
#   of the pattern along with the corresponding file names and line numbers.
git-search-pattern-in-branches() {
  git branch | cut -c3- | xargs git grep "$1"
}

# list-code-workspaces-by-date - List workspaces with their last modified dates.
#
# Usage: list-code-workspaces-by-date
#
# Description:
#   This function searches for all `workspace.json` files in the
#   `~/.config/Code/User/workspaceStorage` directory, retrieves their
#   last modified date, and extracts the folder information using `jq`.
#   The results are formatted to show the date, folder name, and file path,
#   sorted by date. The output is also saved to a log file at `/tmp/workspaces.log.txt`.
#
list-code-workspaces-by-date() {
  fd -t f workspace.json ~/.config/Code/User/workspaceStorage | while read line; do
    date=$(stat -c %y "$line")
    file=$(jq .folder "$line")
    echo "$date $file $line" | awk '{print $1" "$4" "$5}'
  done | sort -k1 | tee /tmp/workspaces.log.txt
}

# list-directories-by-date - List directories sorted by their last modified date.
#
# Usage: list-directories-by-date <pattern> <path>
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
list-directories-by-date() {
  fd -t d $1 $2 | while read line; do
    date=$(stat -c %y $line)
    echo "$date $line"
  done | sort -k1
}

# make-file - Create a file and its parent directories if they do not exist.
#
# Usage: make-file <file_path>
#
# Parameters:
#   file_path - The path of the file to create, including any necessary parent directories.
#
# Description:
#   This function creates the specified file at the given path. If the parent
#   directories do not already exist, they will be created using `mkdir -p`.
#   After ensuring that the directory structure is in place, it uses `touch`
#   to create the file or update its timestamp if it already exists.
make-file() {
  mkdir -p "$(dirname "$1")" && touch "$1"
}

# find-text - Search for text in files and display matching lines with context.
#
# Usage: find-text <search_text> <?directory>
#
# Parameters:
#   search_text - The text or pattern to search for within the specified files.
#   directory    - The directory or path where the search should be performed. If not provided, the current directory is used.
#
# Description:
#   This function uses `grep` to recursively search for the specified text in
#   the files located in the given directory. It highlights matches and shows
#   the line number of each match. The output is limited to the first 250 characters
#   of each matching line for easier readability.
find-text() {
  if [ $# -lt 2 ]; then
    DIR=$(pwd)
  else
    DIR=$2
  fi
  grep --color=always -HnRE --exclude-dir="vendor" --exclude-dir="env" --exclude-dir="venv" --exclude-dir="node_modules" --exclude-dir=".git" "$1" "$DIR" | awk '{ print substr($0, 1, length($0) < 250 ? length($0) : 250) }'
}

# find-directory - Find directories by name and display their last modified dates.
#
# Usage: find-directory <directory_name>
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

find-directory() {
  find . -name "$1" -prune -exec sh -c "echo -n \"{}\"; stat -c \" %y\" \"{}\"" \; | awk "{print \$2\" \"\$1}" | sort -k1
}

# video2frames - Convert a video file into a series of PNG images.
#
# Usage: video2frames <video_path>
#
# Parameters:
#   video_path - The path to the input video file to be converted into images.
#
# Description:
#   This function uses `ffmpeg` to extract frames from the specified video file
#   and save them as PNG images. The images will be named using a zero-padded
#   numbering format (e.g., `0000000001.png`, `0000000002.png`, etc.).
video2frames() {
  # $1 = video path
  ffmpeg -i "$1" %010d.png
}

# frames2video - Create a video file from a series of PNG images.
#
# Usage: frames2video <output_video_filename> <frames_per_second>
#
# Parameters:
#   output_video_filename - The name of the output video file to be created (with extension).
#   frames_per_second      - The frame rate for the output video.
#
# Description:
#   This function uses `ffmpeg` to compile a series of PNG images into a video file.
#   The images should be named in a way that allows them to be matched by the glob pattern.
#   The output video is encoded using the H.264 codec with a specified frame rate.
frames2video() {
  ffmpeg -r "$2" -f image2 -pattern_type glob -i "*.png" -vcodec libx264 -crf 20 -pix_fmt yuv420p "$1"
}

# cut-video - Cut a segment from a video file using ffmpeg.
#
# Usage: cut-video <input_filename> <start_time> <duration> <output_filename>
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
#   cut-video "input.mp4" "00:01:30" "00:00:10" "output"
#   # This will extract a 10-second segment starting from 1 minute and 30 seconds
#   # into "input.mp4" and save it as "output.mp4".
cut-video() {
  echo "ffmpeg -hide_banner -i $1 -ss $2 -t $3 -c copy $4.mp4"
  ffmpeg -hide_banner -i "$1" -ss "$2" -t "$3" -c copy "$4.mp4"
}

# get-fps - Calculate and round the average frame rate of a video file.
#
# Usage: get-fps <video_file>
#
# Parameters:
#   video_file - The path to the video file for which to calculate the average frame rate.
#
# Description:
#   This function uses `ffprobe` to extract the average frame rate of the specified
#   video file. It retrieves the frame rate as a fraction and then uses Python to
#   round the value to the nearest integer. The rounded frame rate is printed to the
#   standard output.

get-fps() {
  fraction=$(ffprobe -v error -select_streams v:0 -show_entries stream=avg_frame_rate -of default=nw=1:nk=1 "$1")
  python -c "print(round(${fraction}))"
}

# m3u-download - Download a video stream from an .m3u8 playlist file using ffmpeg.
#
# Usage: m3u-download <m3u8_url> <output_filename>
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
#   m3u-download "http://example.com/playlist.m3u8" "output.mp4"
#   # This will download the video stream from the specified .m3u8 URL and save
#   # it as "output.mp4".

m3u-download() {
  if [ -f headers.txt ]; then
    headers=$(awk '{print}' ORS='\r\n' headers.txt)
    # echo \"ffmpeg -headers "$headers" -i "$1" -c copy -bsf:a aac_adtstoasc "$2"\"
    ffmpeg -headers "$headers" -i "$1" -c copy -bsf:a aac_adtstoasc "$2"
  else
    ffmpeg -i "$1" -c copy -bsf:a aac_adtstoasc "$2"
  fi
}

# print-colors - Display a list of ANSI colors with their corresponding codes.
#
# Usage: print-colors
#
# Description:
#   This function prints out a series of ANSI colors (from 0 to 7) along with
#   their corresponding escape codes. Each color is displayed in its respective
#   color format, allowing users to see how the colors appear in the terminal.

print-colors() {
  for i in {0..7}; do
    echo -e "\e[3${i}m ${i} Color: '\\\033[3${i}m' \e[0m"
  done
}

# docker-compose-build - Build Docker containers using a specified Docker Compose file.
#
# Usage: docker-compose-build <docker_compose_file>
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
#   docker-compose-build "docker-compose.yml"
#   # This will build the containers defined in "docker-compose.yml".

docker-compose-build() {
  docker compose -f "$1" build
}

# docker-compose-up - Start Docker containers using a specified Docker Compose file.
#
# Usage: docker-compose-up <docker_compose_file>
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
#   docker-compose-up "docker-compose.yml"
#   # This will start the containers defined in "docker-compose.yml".

docker-compose-up() {
  docker compose -f "$1" up
}

# pip-install-break - Install Python packages using pip3 with system package break handling.
#
# Usage: pip-install-break <packages>
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
#   pip-install-break "numpy pandas"
#   # This will install the packages "numpy" and "pandas" using pip3.

pip-install-break() {
  pip3 install "$1" --break-system-packages
}

# remove-colors() - Remove ANSI color codes from input
#
# This function processes input text to remove ANSI escape sequences
# that are used for coloring in terminal output. It utilizes the `sed`
# command with a regular expression to match and strip out these codes,
# allowing for cleaner output without any formatting artifacts.
#
# Usage:
#   remove-colors < input_file > output_file
#
# Example:
#   cat colored_output.txt | remove-colors > plain_output.txt
#
# Note:
#   This function is designed to be used in a pipeline or with input redirection.
remove-colors() {
  sed -r "s/\x1B\[[0-9;]*m//g"
}
# Function: copy-with-exclusion
# --------------------------
# Copies files from a source directory to a destination directory while excluding
# specified directories from the copy process. This function utilizes `rsync` for
# efficient file transfer and exclusion handling.
#
# Parameters:
#   source_dir (string): The path to the source directory from which files will be copied.
#   dest_dir (string): The path to the destination directory where files will be copied to.
#   exclude_dirs (array): A list of directory patterns to exclude from the copy process.
#
# Usage:
#   copy-with-exclusion <source_dir> <dest_dir> <exclude_dirs>
#
# Example:
#   copy-with-exclusion /home/user/source /home/user/destination temp cache
#
# Note:
#   - The function uses `rsync` with the `-a` (archive) and `-v` (verbose) options.
#   - The exclude patterns are passed to `rsync` using the --exclude option.
copy-with-exclusion() {
  local source_dir="$1"
  local dest_dir="$2"
  shift 2
  local exclude_dirs=("$@")

  # Build the exclude options for rsync
  local exclude_options=""
  for dir in "${exclude_dirs[@]}"; do
    exclude_options+="--exclude='$dir' "
  done

  # Use rsync to copy while excluding specified directories
  eval "rsync -av $exclude_options '$source_dir/' '$dest_dir/'"
}

# Open the remote repository URL in the current branch at the browser.
#
# This function utilizes `git config` to retrieve the remote origin URL,
# performs string substitution to convert the URL to a browsable format,
# and then uses `xdg-open` to launch the default browser with the URL.
openrb() {
  git config --get remote.origin.url | sed s"/work.//" | sed s"/:/\//" | sed s"/git@/https:\/\//" | sed s"/\.git//" | xargs -I{} xdg-open {}/tree/$(git rev-parse --abbrev-ref HEAD)
}

openj() {
  xdg-open https://queroquitar.atlassian.net/browse/$(git rev-parse --abbrev-ref HEAD | cut -f2 --delimiter="/")
}

# Split a video file into multiple segments based on specified time intervals.
#
# Usage:
#   split_by_time <input_file> <segment_duration>
#
# Parameters:
#   input_file (string): The path to the video file to be split.
#   segment_duration (string): The duration for each video segment (e.g., "00:05:00" for 5 minutes).
#
# Description:
#   This function uses `ffmpeg` to split the input video file into segments of a specified duration.
#   Each segment is saved as a separate file with a sequential naming pattern (e.g., output_001.mp4).
#
# Example:
#   split_by_time "video.mp4" "00:05:00"
#   # This will split "video.mp4" into 5-minute segments.

split_by_time() {
  ffmpeg -i $1 -c copy -map 0 -segment_time $2 -f segment -reset_timestamps 1 output_%03d.mp4
}

# Join split videos created by split_by_time() into a single video file.
#
# Usage:
#   join_split_videos
#
# Notes:
#   - The function creates a videos.txt file containing the list of split video files.
#   - It then uses ffmpeg to concatenate the split video files into a single output.mp4 file.
join_split_videos() {
  for f in *.mp4; do echo "file '$f'" >>videos.txt; done
  ffmpeg -f concat -i videos.txt -c copy output.mp4
}

# Replace OLD_NAME with NEW_NAME in string NAME.
#
# Args:
#   NAME: The string to modify.
#   OLD_NAME: The substring to replace.
#   NEW_NAME: The substring to replace OLD_NAME with.
#
# Returns:
#   The modified string.
replace() {
  NAME="$1"
  OLD_NAME="$2"
  NEW_NAME="$3"

  echo "$NAME" | sed "s/$OLD_NAME/$NEW_NAME/"
}


cdl(){
  z $(readlink -f $1)
}
