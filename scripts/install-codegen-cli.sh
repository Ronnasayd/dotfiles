#!/bin/bash
mkdir -p "$HOME/codegen/"
wget https://repo1.maven.org/maven2/io/swagger/codegen/v3/swagger-codegen-cli/3.0.71/swagger-codegen-cli-3.0.71.jar -O "$HOME/codegen/codegen-cli.jar"

sudo tee /usr/local/bin/codegen > /dev/null <<EOF
#!/bin/bash
java -jar "$HOME/codegen/codegen-cli.jar" "\$@"
EOF

sudo chmod +x /usr/local/bin/codegen
