#!/usr/bin/python3
import json
import os
import sqlite3
import sys
from pathlib import Path
from urllib.parse import unquote, urlparse


def get_db_path():
    if sys.platform.startswith("linux") or sys.platform == "darwin":
        return Path.home() / ".config/Code/User/globalStorage/state.vscdb"
    elif sys.platform == "win32":
        return Path(os.environ["APPDATA"]) / "Code/User/globalStorage/state.vscdb"
    else:
        raise RuntimeError("Unsupported OS")


def extract_paths_from_entry(entry):
    if isinstance(entry, dict):
        uri = entry.get("folderUri") or entry.get("workspace", {}).get("configURIPath")
    else:
        uri = entry
    if uri and uri.startswith("file://"):
        path = unquote(urlparse(uri).path)
        return path
    return None


def get_recent_paths(db_path):
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    try:
        cursor.execute("SELECT key, value FROM ItemTable")
        rows = cursor.fetchall()
    except Exception as e:
        print(f"Failed to read state.vscdb: {e}")
        return []

    for key, value in rows:
        if key.startswith("history.recentlyOpenedPathsList") or "recentlyOpened" in key:
            try:
                parsed = json.loads(value)
                entries = parsed.get("entries") or parsed.get("workspaces3") or []
                return [
                    extract_paths_from_entry(e)
                    for e in entries
                    if extract_paths_from_entry(e)
                ]
            except Exception:
                continue

    return []


def main():
    db_path = get_db_path()
    if not db_path.exists():
        print(f"VS Code state database not found at: {db_path}")
        sys.exit(1)

    paths = get_recent_paths(db_path)

    if not paths:
        print("No recent workspaces or folders found.")
        return

    print("Recent VS Code Workspaces and Folders (most recent first):")
    for i, path in enumerate(paths, 1):
        print(f"{path}")


if __name__ == "__main__":
    main()
