#!/home/ronnas/develop/personal/dotfiles/conky/themes/MyMimosa/python/venv/bin/python3
import json
import textwrap

import feedparser
from bs4 import BeautifulSoup

rss = [
    "https://rss.tecmundo.com.br/feed",
    "https://plus.diolinux.com.br/c/noticias-tecnologia/20.rss",
    "https://rss.uol.com.br/feed/tecnologia.xml",
    "https://olhar-digital-online.webnode.page/rss/all.xml",
    # "https://www.tabnews.com.br/recentes/rss",
    "https://g1.globo.com/dynamo/tecnologia/rss2.xml",
    # "http://feeds.feedburner.com/blogspot/gJZg",
    # "https://towardsdatascience.com/feed"
]


def get_clear_text(summary):
    soup = BeautifulSoup(summary, "html.parser")
    clean_text = soup.get_text().strip()
    return clean_text


data = []
total_height = 12
for url in rss:
    feed = feedparser.parse(url)
    for entry in feed.entries:
        summary = entry.summary
        if url == "https://rss.tecmundo.com.br/feed":
            summary = entry.content[0].value
        # if url == "https://rss.uol.com.br/feed/tecnologia.xml":
        #     print(summary)
        wrapped_title = textwrap.fill(entry.title, width=25)
        wrapped_summary = textwrap.fill(get_clear_text(summary), width=30)
        title_height = len(wrapped_title.split("\n"))
        summary_height = len(wrapped_summary.split("\n"))
        diff_height = total_height - title_height
        dd_height = diff_height - summary_height
        if dd_height > 0:
            wrapped_summary += "\n" * dd_height
        else:
            wrapped_summary = "\n".join(wrapped_summary.split("\n")[0:diff_height])
        data.append(dict(title=wrapped_title, summary=wrapped_summary, url=entry.link))

with open("/tmp/rss.json", "w", encoding="utf-8") as file:
    file.write(json.dumps(data, ensure_ascii=False))
