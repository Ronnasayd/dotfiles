#!/home/ronnas/develop/personal/dotfiles/conky/themes/MyMimosa/python/venv/bin/python3
import json
import sys

with open("/tmp/rss.json") as file:
    data = json.loads(file.read())

if __name__ == "__main__":
    offset = 40
    interval = 30
    if len(sys.argv) > 1:
        time_param = sys.argv[1]
        index = int((int(time_param) / interval) % len(data))
        title = data[index]["title"].replace("\n", f"\n${{offset {offset}}}")
        summary = data[index]["summary"].replace("\n", f"\n${{offset {offset}}}")
        source = data[index]["source"].replace("\n", f"\n${{offset {offset}}}")
        print(
            f"${{offset {offset}}}${{font FiraCode Nerd Font:size=12}} ${{font Roboto:bold:size=8}}{source}"
        )
        print(f"${{voffset 6}}${{offset {offset}}}${{font Roboto:bold:size=10}}{title}")
        print(f"${{voffset 8}}${{font Roboto:size=9}}${{offset {offset}}}{summary}...")
        with open("/tmp/rss.txt", "w", encoding="utf-8") as file:
            file.write(data[index]["url"])
    else:
        print("No time parameter provided")
