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
    "peterj.proto",
]

js = [
    "dbaeumer.vscode-eslint",
    "ms-vscode.js-debug-nightly",
    "xabikos.javascriptsnippets",
    "esbenp.prettier-vscode",
    "dsznajder.es7-react-js-snippets",
    "christian-kohler.path-intellisense",
    "editorconfig.editorconfig",
]
html = [
    "formulahendry.auto-rename-tag",
    "naumovs.color-highlight",
    "pranaygp.vscode-css-peek",
    "vincaslt.highlight-matching-tag",
    "ecmel.vscode-html-css",
    "htmlhint.vscode-htmlhint",
    "celianriboulet.webvalidator",
]
tailwindcss = [
    "bradlc.vscode-tailwindcss",
    "cpylua.language-postcss",
    "moalamri.inline-fold",
]
cpp = [
    "ms-vscode.cpptools",
    "ms-vscode.cpptools-extension-pack",
    "ms-vscode.cpptools-themes",
    "jeff-hykin.better-cpp-syntax",
]

cmake = [
    "twxs.cmake",
    "josetr.cmake-language-support-vscode",
    "ms-vscode.cmake-tools",
    "ms-vscode.makefile-tools",
]

lua = ["trixnz.vscode-lua", "sumneko.lua"]

xml = ["redhat.vscode-xml", "dotjoshjohnson.xml"]

yaml = ["redhat.vscode-yaml"]

vue2 = ["octref.vetur", "dariofuzinato.vue-peek"]
vue3 = ["Vue.volar", "hollowtree.vue-snippets"]

with open("/tmp/extensions_uuid.txt", encoding="utf-8") as file:
    curdir = os.getcwd()
    data = file.read().split("\n")
    data_py = "\n".join([line for line in data if line.split(" ")[0] in py])
    data_go = "\n".join([line for line in data if line.split(" ")[0] in go])
    data_js = "\n".join([line for line in data if line.split(" ")[0] in js])
    data_html = "\n".join([line for line in data if line.split(" ")[0] in html])
    data_tailwindcss = "\n".join(
        [line for line in data if line.split(" ")[0] in tailwindcss]
    )
    data_cpp = "\n".join([line for line in data if line.split(" ")[0] in cpp])
    data_cmake = "\n".join([line for line in data if line.split(" ")[0] in cmake])
    data_lua = "\n".join([line for line in data if line.split(" ")[0] in lua])
    data_xml = "\n".join([line for line in data if line.split(" ")[0] in xml])
    data_yaml = "\n".join([line for line in data if line.split(" ")[0] in yaml])
    data_vue2 = "\n".join([line for line in data if line.split(" ")[0] in vue2])
    data_vue3 = "\n".join([line for line in data if line.split(" ")[0] in vue3])

    with open(f"{curdir}/languagens/py.txt", "w", encoding="utf-8") as file:
        file.write(data_py)
    with open(f"{curdir}/languagens/go.txt", "w", encoding="utf-8") as file:
        file.write(data_go)
    with open(f"{curdir}/languagens/js.txt", "w", encoding="utf-8") as file:
        file.write(data_js)
    with open(f"{curdir}/languagens/html.txt", "w", encoding="utf-8") as file:
        file.write(data_html)
    with open(f"{curdir}/languagens/tailwindcss.txt", "w", encoding="utf-8") as file:
        file.write(data_tailwindcss)
    with open(f"{curdir}/languagens/cpp.txt", "w", encoding="utf-8") as file:
        file.write(data_cpp)
    with open(f"{curdir}/languagens/cmake.txt", "w", encoding="utf-8") as file:
        file.write(data_cmake)
    with open(f"{curdir}/languagens/lua.txt", "w", encoding="utf-8") as file:
        file.write(data_lua)
    with open(f"{curdir}/languagens/xml.txt", "w", encoding="utf-8") as file:
        file.write(data_xml)
    with open(f"{curdir}/languagens/yaml.txt", "w", encoding="utf-8") as file:
        file.write(data_yaml)
    with open(f"{curdir}/languagens/vue2.txt", "w", encoding="utf-8") as file:
        file.write(data_vue2)
    with open(f"{curdir}/languagens/vue3.txt", "w", encoding="utf-8") as file:
        file.write(data_vue3)
