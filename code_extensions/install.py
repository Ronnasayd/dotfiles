#!/usr/bin/python3
import json
import os

with open("./map-extensions.json", encoding="utf-8") as file:
    data = json.loads(file.read())
    keys = list(data.keys())

with open("/home/ronnas/.vscode/extensions/extensions.json", encoding="utf-8") as file:
    curdir = os.getcwd()
    extensions = json.loads(file.read())
    new_data = {}
    for key in keys:
        new_data[key] = []
        for extension in extensions:
            _id = extension["identifier"]["id"]
            _uuid = extension["identifier"]["uuid"]
            if _id in data[key]:
                new_data[key].append(dict(id=_id, uuid=_uuid))

    with open(f"{curdir}/languagens/languages.json", "w", encoding="utf-8") as file:
        result = {}
        for key in keys:
            result[key] = new_data[key]
        file.write(
            json.dumps(
                result
            )
        )
