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
    languages = list(json.loads(file.read()).keys())

def disable(language: str):
    add, path = get_data(language)
    print(add, path)
    conn = sqlite3.connect("/tmp/state.vscdb")
    cursor = conn.cursor()
    key, value = cursor.execute(
        "select * from ItemTable WHERE KEY IS 'extensionsIdentifiers/enabled'"
    ).fetchone()
    extensions = json.loads(value)
    ids = [a["id"] for a in add]
    extensions = [ext for ext in extensions if ext["id"] not in ids]
    cursor.execute(
        "UPDATE ItemTable SET VALUE = ? WHERE KEY IS ?", (json.dumps(extensions), key)
    )
    conn.commit()
    conn.close()
    shutil.copyfile("/tmp/state.vscdb", path)


def enable(language: str):
    add, path = get_data(language)
    conn = sqlite3.connect("/tmp/state.vscdb")
    cursor = conn.cursor()
    key, value = cursor.execute(
        "select * from ItemTable WHERE KEY IS 'extensionsIdentifiers/enabled'"
    ).fetchone()
    extensions = json.loads(value)
    extensions = [*extensions, *add]
    extensions = [dict(t) for n, t in enumerate(extensions) if t not in extensions[:n]]
    cursor.execute(
        "UPDATE ItemTable SET VALUE = ? WHERE KEY IS ?", (json.dumps(extensions), key)
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
    conn = sqlite3.connect("/tmp/state.vscdb")
    cursor = conn.cursor()
    _, value = cursor.execute(
        "select * from ItemTable WHERE KEY IS 'extensionsIdentifiers/enabled'"
    ).fetchone()
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
        verify_code_is_open()
        enable(args.enable)
    if args.disable:
        verify_code_is_open()
        disable(args.disable)
    


if __name__ == "__main__":
    main()
