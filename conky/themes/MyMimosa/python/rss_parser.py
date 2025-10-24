#!/home/ronnas/develop/personal/dotfiles/conky/themes/MyMimosa/python/venv/bin/python3
import json
import textwrap
from datetime import datetime, timedelta, timezone
from langdetect import detect
from langdetect.lang_detect_exception import LangDetectException
import feedparser
from bs4 import BeautifulSoup

rss = [
    {"source": "Tecmundo", "url": "https://rss.tecmundo.com.br/feed"},
    {
        "source": "Diolinux",
        "url": "https://plus.diolinux.com.br/c/noticias-tecnologia/20.rss",
    },
    {"source": "Uol-tecnologia", "url": "https://rss.uol.com.br/feed/tecnologia.xml"},
    {
        "source": "G1-tecnologia",
        "url": "https://g1.globo.com/dynamo/tecnologia/rss2.xml",
    },
    # {"source": "Tabnews", "url": "https://www.tabnews.com.br/recentes/rss"},
    {"source": "techcrunch", "url": "https://techcrunch.com/feed/"},
    {
        "source": "IEEESpectrum",
        "url": "https://feeds.feedburner.com/IeeeSpectrumFullText",
    },
    {"source": "Medium-Dev", "url": "https://medium.com/feed/tag/programming"},
    {
        "source": "Medium-Ai",
        "url": "https://medium.com/feed/tag/artificial-intelligence",
    },
    {"source": "Medium-SE", "url": "https://medium.com/feed/tag/software-engineering"},
    {"source": "Medium-DL", "url": "https://medium.com/feed/tag/deep-learning"},
    {"source": "Medium-ML", "url": "https://medium.com/feed/tag/machine-learning"},
    {"source": "Medium-DS", "url": "https://medium.com/feed/tag/data-science"},
    {"source": "Medium-Games", "url": "https://medium.com/feed/tag/gaming"},
    {"source": "Deepmind", "url": "https://deepmind.google/blog/rss.xml"},
    {"source": "towardsdatascience", "url": "https://towardsdatascience.com/feed"},
    {"source": "Uxplanet", "url": "https://uxplanet.org/feed"},
    {"source": "akitaonrails", "url": "https://akitaonrails.com/index.xml"},
    {"source": "technologyreview", "url": "https://www.technologyreview.com/feed/"},
    # {"source": "Hacker-news", "url": "https://news.ycombinator.com/rss"},
    # {"source":"feedburner","url":"http://feeds.feedburner.com/blogspot/gJZg"},
]

WEEKDAY_MAP = {
    "Seg": "Mon",
    "Ter": "Tue",
    "Qua": "Wed",
    "Qui": "Thu",
    "Sex": "Fri",
    "Sáb": "Sat",
    "Dom": "Sun",
}


def translate_weekday(date_str):
    for pt, en in WEEKDAY_MAP.items():
        if date_str.startswith(pt):
            return date_str.replace(pt, en, 1)
    return date_str


def get_clear_text(summary_html):
    soup = BeautifulSoup(summary_html, "html.parser")
    clean_text = soup.get_text().strip()
    return clean_text


def parse_date(date_str):
    formats = [
        "%a, %d %b %Y %H:%M:%S %z",  # e.g. Mon, 14 Jul 2025 13:40:47 +0000
        "%a, %d %b %Y %H:%M:%S %Z",  # e.g. Mon, 14 Jul 2025 13:43:35 GMT
    ]
    for fmt in formats:
        try:
            return datetime.strptime(date_str, fmt).isoformat()
        except ValueError:
            pass
    raise ValueError(f"Date format not recognized: {date_str}")


data = []
total_height = 12
for row in rss:
    url = row["url"]
    print(f"Parsing RSS feed: {url}")
    source = row["source"]
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
        try:
            published = parse_date(translate_weekday(entry.published))
            published_dt = datetime.fromisoformat(published)
        except Exception as e:
            continue
        if published_dt.tzinfo is None:
            published_dt = published_dt.replace(tzinfo=timezone.utc)
        try:
            is_correct_language = detect(wrapped_title) in ['pt','en']
        except LangDetectException as e:
            is_correct_language = False
        if datetime.now(timezone.utc) - published_dt < timedelta(days=60) and is_correct_language:
            data.append(
                dict(
                    title=wrapped_title,
                    summary=wrapped_summary,
                    url=entry.link,
                    source=source,
                    published=published,
                )
            )


data = sorted(data, key=lambda x: x["published"], reverse=True)
with open("/tmp/rss.json", "w", encoding="utf-8") as file:
    file.write(json.dumps(data, ensure_ascii=False))
