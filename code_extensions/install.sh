./install.py
if [ ! -f "/usr/local/bin/wse" ]; then
  ln -s $(pwd)/wse.py /usr/local/bin/wse
fi
