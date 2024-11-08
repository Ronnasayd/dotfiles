code --list-extensions | xargs -I {} sh -c 'echo "{} $(jq -r .__metadata.id ~/.vscode/extensions/{}*/package.json)"' > /tmp/extensions_uuid.txt
./install.py 
ln -s $(pwd)/ws_extensions.py /usr/local/bin/ws_extensions