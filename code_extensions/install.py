#!/usr/bin/python3
import json
import os

with open("./map-extensions.json", encoding="utf-8") as file:
    data = json.loads(file.read())
    py = data["py"]
    go = data["go"]
    js = data["js"]
    html = data["html"]
    tailwindcss = data["tailwindcss"]
    cpp = data["cpp"]
    cmake = data["cmake"]
    lua = data["lua"]
    xml = data["xml"]
    yaml = data["yaml"]
    vue2 = data["vue2"]
    vue3 = data["vue3"]

with open("/home/ronnas/.vscode/extensions/extensions.json", encoding="utf-8") as file:
    curdir = os.getcwd()
    extensions = json.loads(file.read())
    data_py, data_go, data_js, data_html, data_tailwindcss = [], [], [], [], []
    data_cpp = []
    data_cmake = []
    data_lua = []
    data_xml = []
    data_yaml = []
    data_vue2 = []
    data_vue3 = []
    for extension in extensions:
        _id = extension["identifier"]["id"]
        _uuid = extension["identifier"]["uuid"]
        if _id in py:
            data_py.append(dict(id=_id, uuid=_uuid))
        if _id in go:
            data_go.append(dict(id=_id, uuid=_uuid))
        if _id in js:
            data_js.append(dict(id=_id, uuid=_uuid))
        if _id in html:
            data_html.append(dict(id=_id, uuid=_uuid))
        if _id in tailwindcss:
            data_tailwindcss.append(dict(id=_id, uuid=_uuid))
        if _id in cpp:
            data_cpp.append(dict(id=_id, uuid=_uuid))
        if _id in cmake:
            data_cmake.append(dict(id=_id, uuid=_uuid))
        if _id in lua:
            data_lua.append(dict(id=_id, uuid=_uuid))
        if _id in xml:
            data_xml.append(dict(id=_id, uuid=_uuid))
        if _id in yaml:
            data_yaml.append(dict(id=_id, uuid=_uuid))
        if _id in vue2:
            data_vue2.append(dict(id=_id, uuid=_uuid))
        if _id in vue3:
            data_vue3.append(dict(id=_id, uuid=_uuid))

    with open(f"{curdir}/languagens/languages.json", "w", encoding="utf-8") as file:
        file.write(
            json.dumps(
                dict(
                    py=data_py,
                    go=data_go,
                    js=data_js,
                    html=data_html,
                    tailwindcss=data_tailwindcss,
                    cpp=data_cpp,
                    cmake=data_cmake,
                    lua=data_lua,
                    xml=data_xml,
                    yaml=data_yaml,
                    vue2=data_vue2,
                    vue3=data_vue3,
                )
            )
        )
