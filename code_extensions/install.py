#!/usr/bin/python3
import os

py = [
"kevinrose.vsc-python-indent",
"ms-python.black-formatter",
"ms-python.isort",
"ms-python.pylint",
"ms-python.python",
"ms-python.vscode-pylance",
"njqdev.vscode-python-typehint",
]

go = [
"golang.go",
"jinliming2.vscode-go-template",
"maxnatchanon.go-struct-tag-autogen",
]

js = [
  "dbaeumer.vscode-eslint",
  "ms-vscode.js-debug-nightly",
  "xabikos.javascriptsnippets",
  "esbenp.prettier-vscode",
  "steoates.autoimport",
  "dsznajder.es7-react-js-snippets"
]

with open("/tmp/extensions_uuid.txt") as file:
  curdir = os.getcwd()
  data = file.read().split("\n")
  data_py = "\n".join([line for line in data if line.split(" ")[0] in py])
  data_go = "\n".join([line for line in data if line.split(" ")[0] in go])
  data_js = "\n".join([line for line in data if line.split(" ")[0] in js])
  with open(f"{curdir}/py.txt", "w") as file:
    file.write(data_py)
  with open(f"{curdir}/go.txt", "w") as file:
    file.write(data_go)  
  with open(f"{curdir}/js.txt", "w") as file:
    file.write(data_js)  