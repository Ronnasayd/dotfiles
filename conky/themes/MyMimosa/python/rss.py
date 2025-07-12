#!/home/ronnas/develop/personal/dotfiles/conky/themes/MyMimosa/python/venv/bin/python3
import json
import sys

with open("/tmp/rss.json") as  file:
    data = json.loads(file.read())

if __name__ == "__main__":
    offset = 40
    interval = 30
    if len(sys.argv) > 1:
        time_param = sys.argv[1]
        index = int(( int(time_param)/interval) % len(data))
        title= data[index]["title"].replace("\n",f'\n${{offset {offset}}}')
        summary= data[index]["summary"].replace("\n",f'\n${{offset {offset}}}')
        print(f'${{font Roboto:bold:size=10}}${{offset {offset}}}{title}\n')
        print(f'${{font Roboto:size=9}}${{offset {offset}}}{summary}...')
    else:
        print("No time parameter provided")
