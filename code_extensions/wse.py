#!/usr/bin/python3
import argparse
import json
import os
import shutil
import sqlite3
import subprocess

from attr import dataclass
from click import pass_obj

base_path = "/home/ronnas/develop/personal/dotfiles/code_extensions"
with open(f"{base_path}/map-extensions.json", encoding="utf-8") as file:
    data = file.read()
    languages = list(json.loads(data).keys())
    map_extensions = json.loads(data)
    
def enable_extensions_json(language):
    data = map_extensions[language]
    curr = os.getcwd()
    if not os.path.exists(f"{curr}/.vscode"):
        os.makedirs(f"{curr}/.vscode",exist_ok=True)
        if not os.path.exists(f"{curr}/.vscode/extensions.json"):
            with open(f"{curr}/.vscode/extensions.json", "w", encoding="utf-8") as file:
                file.write(json.dumps({"recommendations": []}))
    with open(f"{curr}/.vscode/extensions.json", "r", encoding="utf-8") as file:
        extensions = json.loads(file.read())
    with open(f"{curr}/.vscode/extensions.json", "w", encoding="utf-8") as file:
        extensions["recommendations"] = [*extensions["recommendations"],*data]
        file.write(json.dumps(extensions))

def disable_extensions_json(language):
    data = map_extensions[language]
    curr = os.getcwd()
    if not os.path.exists(f"{curr}/.vscode"):
        os.makedirs(f"{curr}/.vscode",exist_ok=True)
        if not os.path.exists(f"{curr}/.vscode/extensions.json"):
            with open(f"{curr}/.vscode/extensions.json", "w", encoding="utf-8") as file:
                file.write(json.dumps({"recommendations": []}))
    with open(f"{curr}/.vscode/extensions.json", "r", encoding="utf-8") as file:
        extensions = json.loads(file.read())
    with open(f"{curr}/.vscode/extensions.json", "w", encoding="utf-8") as file:
        extensions["recommendations"]  = list(filter(lambda x: x not in data, extensions["recommendations"]))
        file.write(json.dumps(extensions))

def disable(language: str):
    # disable_extensions_json(language)
    verify_code_is_open()
    add, path = get_data(language)
    conn = sqlite3.connect("/tmp/state.vscdb")
    cursor = conn.cursor()
    fetchone = cursor.execute(
        "select * from ItemTable WHERE KEY IS 'extensionsIdentifiers/enabled'"
    ).fetchone()
    if fetchone is not None:
        _,value = fetchone
        extensions = json.loads(value)
        ids = [a["id"] for a in add]
        extensions = [ext for ext in extensions if ext["id"] not in ids]
        cursor.execute(
            "UPDATE ItemTable SET VALUE = ? WHERE KEY IS ?", (json.dumps(extensions), 'extensionsIdentifiers/enabled')
        )
        conn.commit()
        conn.close()
        shutil.copyfile("/tmp/state.vscdb", path)




def enable(language: str):
    # enable_extensions_json(language)
    verify_code_is_open()
    add, path = get_data(language)
    
    conn = sqlite3.connect("/tmp/state.vscdb")
    cursor = conn.cursor()
    
    cursor.execute(
        "SELECT VALUE FROM ItemTable WHERE KEY = ?", ('extensionsIdentifiers/enabled',)
    )
    fetchone = cursor.fetchone()
    
    if fetchone is not None:
        (value,) = fetchone
        extensions = json.loads(value)
        extensions.extend(add)
    else:
        extensions = add
    
    # Remove duplicates while preserving order
    seen = set()
    unique_extensions = []
    for ext in extensions:
        # Convert dict to tuple of items to make it hashable for the set
        ext_tuple = tuple(sorted(ext.items())) if isinstance(ext, dict) else ext
        if ext_tuple not in seen:
            seen.add(ext_tuple)
            unique_extensions.append(ext)
    
    extensions_json = json.dumps(unique_extensions)
    
    if fetchone is not None:
        cursor.execute(
            "UPDATE ItemTable SET VALUE = ? WHERE KEY = ?", (extensions_json, 'extensionsIdentifiers/enabled')
        )
    else:
        cursor.execute(
            "INSERT INTO ItemTable (KEY, VALUE) VALUES (?, ?)", ('extensionsIdentifiers/enabled', extensions_json)
        )
    
    conn.commit()
    conn.close()
    
    shutil.copyfile("/tmp/state.vscdb", path)



def get_data(language):
    with open(f"{base_path}/languagens/languages.json", encoding="utf-8") as file:
        data = json.loads(file.read())
        add = data[language]
    curr = os.getcwd()
    path = (
        subprocess.run(
            f"{base_path}/copy-vscdb.sh {curr}".split(),
            check=False,
            stdout=subprocess.PIPE,
        )
        .stdout.decode()
        .strip()
    )

    return add, path


def list_extensions():
    curr = os.getcwd()
    path = (
        subprocess.run(
            f"{base_path}/copy-vscdb.sh {curr}".split(),
            check=False,
            stdout=subprocess.PIPE,
        )
        .stdout.decode()
        .strip()
    )
    print(f"using file: {path}")
    conn = sqlite3.connect("/tmp/state.vscdb")
    cursor = conn.cursor()
    fetchone = cursor.execute(
        "select * from ItemTable WHERE KEY IS 'extensionsIdentifiers/enabled'"
    ).fetchone()
    if fetchone is not None:
        _,value = fetchone
        extensions = json.loads(value)
        for extension in extensions:
            print(extension["id"])

def verify_code_is_open():
    status = (
        subprocess.run(
            f"pgrep -x code".split(),
            check=False,
            stdout=subprocess.PIPE,
        )
        .stdout.decode()
        .strip()
    )
    if status != "":
        print("Code is running. Please close all")
        exit(1)

def main():
    parser = argparse.ArgumentParser(
        description="Enable or disable language extensions to a workspace in vscode"
    )
    parser.add_argument("--enable", choices=languages)
    parser.add_argument("--disable", choices=languages)
    parser.add_argument("-list", action="store_true")
    args = parser.parse_args()
    if args.list:
        list_extensions()
    if args.enable:
        enable(args.enable)
    if args.disable:
        disable(args.disable)
    


if __name__ == "__main__":
    main()
