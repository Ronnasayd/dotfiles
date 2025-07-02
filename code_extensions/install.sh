./install.py
if [[ ! -f "/usr/local/bin/ws_extensions" ]]; then
  ln -s $(pwd)/ws_extensions.py /usr/local/bin/ws_extensions
fi
