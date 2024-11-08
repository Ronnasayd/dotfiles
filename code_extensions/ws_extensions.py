#!/usr/bin/python3
import argparse
import json
import os
import shutil
import sqlite3
import subprocess

base_path = "/home/ronnas/develop/personal/dotfiles/code_extensions"
languages = [
    "py",
    "go",
    "js",
    "html",
    "tailwindcss",
    "cpp",
    "cmake",
    "lua",
    "xml",
    "yaml",
    "vue2",
    "vue3",
]


def close_code():
    (
        subprocess.run(
            "killall code".split(),
            check=False,
            stdout=subprocess.PIPE,
        )
        .stdout.decode()
        .strip()
    )


def reopen_code():
    (
        subprocess.run(
            "code".split(),
            check=False,
            stdout=subprocess.PIPE,
        )
        .stdout.decode()
        .strip()
    )


def disable(language: str):
    add, path = get_data(language)
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
    with open(f"{base_path}/languagens/{language}.txt", encoding="utf-8") as file:
        lines = file.read().split("\n")
        add = []
        for line in lines:
            _id, _uuid = line.split()
            add.append({"id": _id, "uuid": _uuid})
    curr = os.getcwd()
    path = (
        subprocess.run(
            f"{base_path}/ws_extensions.sh {curr}".split(),
            check=False,
            stdout=subprocess.PIPE,
        )
        .stdout.decode()
        .strip()
    )

    return add, path


def main():
    parser = argparse.ArgumentParser(
        description="Enable or disable language extensions to a workspace in vscode"
    )
    parser.add_argument("--enable", choices=languages)
    parser.add_argument("--disable", choices=languages)
    args = parser.parse_args()
    if args.enable:
        close_code()
        enable(args.enable)
        reopen_code()
    if args.disable:
        close_code()
        disable(args.disable)
        reopen_code()


if __name__ == "__main__":
    main()
