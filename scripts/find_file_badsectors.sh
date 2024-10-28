echo 3 | sudo tee /proc/sys/vm/drop_caches
# simply read files to RAM
find . -type f -exec cat '{}' >/dev/zero \;
