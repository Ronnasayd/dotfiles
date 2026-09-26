#!/usr/bin/env python3
# /// script
# dependencies = [
#     "beautifulsoup4",
#     "feedparser",
#     "langdetect",
#     "requests",
# ]
# ///
"""Fetch configured RSS feeds and dump filtered entries to /tmp/rss.json."""

from datetime import UTC, datetime, timedelta
import json
import logging
import textwrap

from bs4 import BeautifulSoup, Tag
import feedparser  # type: ignore[import-untyped]
from langdetect import detect  # type: ignore[import-untyped]
from langdetect.lang_detect_exception import (  # type: ignore[import-untyped]
    LangDetectException,
)
import requests

logging.basicConfig(level=logging.INFO, format="%(message)s")
logger = logging.getLogger(__name__)

RSS_FEEDS = [
    {"source": "towardsdatascience", "url": "https://towardsdatascience.com/feed"},
    {"source": "akitaonrails", "url": "https://akitaonrails.com/index.xml"},
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
    {"source": "Uxplanet", "url": "https://uxplanet.org/feed"},
    {"source": "technologyreview", "url": "https://www.technologyreview.com/feed/"},
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

TOTAL_HEIGHT = 12
MAX_AGE = timedelta(days=60)
OUTPUT_PATH = "/tmp/rss.json"  # noqa: S108 -- shared contract with conky's rss.py/rss.html


def translate_weekday(date_str: str) -> str:
    """Translate a leading Portuguese weekday abbreviation to English.

    :param date_str: Date string possibly starting with a pt-BR weekday.
    :return: The date string with the weekday translated, unchanged otherwise.
    """
    for pt, en in WEEKDAY_MAP.items():
        if date_str.startswith(pt):
            return date_str.replace(pt, en, 1)
    return date_str


def get_clear_text(summary_html: str) -> str:
    """Strip HTML tags from a feed summary and return plain text.

    :param summary_html: Raw HTML summary from a feed entry.
    :return: Plain text with surrounding whitespace stripped.
    """
    soup = BeautifulSoup(summary_html, "html.parser")
    return soup.get_text().strip()


def parse_date(date_str: str) -> str:
    """Parse an RFC-822-style date string into an ISO 8601 string.

    :param date_str: Date string in one of the supported RSS formats.
    :return: ISO 8601 formatted date string.
    :raises ValueError: If the date string matches no supported format.
    """
    formats = [
        "%a, %d %b %Y %H:%M:%S %z",
        "%a, %d %b %Y %H:%M:%S %Z",
    ]
    for fmt in formats:
        try:
            return datetime.strptime(date_str, fmt).isoformat()
        except ValueError:
            pass
    raise ValueError(f"Date format not recognized: {date_str}")


def fetch_feed(url: str) -> feedparser.FeedParserDict | None:
    """Download and parse one RSS feed, returning None on failure.

    :param url: Feed URL to fetch.
    :return: Parsed feed, or None if the request failed.
    """
    try:
        response = requests.get(url, timeout=30)
        response.raise_for_status()
        return feedparser.parse(response.content)
    except requests.exceptions.Timeout:
        logger.warning("Timeout parsing RSS feed: %s", url)
    except requests.exceptions.RequestException as exc:
        logger.warning("Error parsing RSS feed: %s - %s", url, exc)
    return None


def wrap_and_trim(title: str, summary_html: str) -> tuple[str, str]:
    """Wrap title/summary to fixed widths and pad/trim to a total line budget.

    :param title: Raw entry title.
    :param summary_html: Raw entry summary HTML.
    :return: Tuple of (wrapped_title, wrapped_summary).
    """
    wrapped_title = textwrap.fill(title, width=25)
    wrapped_summary = textwrap.fill(get_clear_text(summary_html), width=30)
    title_height = len(wrapped_title.split("\n"))
    summary_height = len(wrapped_summary.split("\n"))
    remaining = TOTAL_HEIGHT - title_height - summary_height
    if remaining > 0:
        wrapped_summary += "\n" * remaining
    else:
        wrapped_summary = "\n".join(
            wrapped_summary.split("\n")[0 : TOTAL_HEIGHT - title_height]
        )
    return wrapped_title, wrapped_summary


def extract_image(entry: feedparser.FeedParserDict, summary_html: str) -> str:
    """Best-effort image URL for an entry: media fields, enclosure, then inline img.

    :param entry: Feed entry to inspect.
    :param summary_html: Raw summary HTML to fall back to for an inline `<img>`.
    :return: Image URL, or empty string if none was found.
    """
    for media in getattr(entry, "media_thumbnail", []) + getattr(
        entry, "media_content", []
    ):
        if media.get("url"):
            return str(media["url"])
    for link in getattr(entry, "links", []):
        if link.get("type", "").startswith("image/") and link.get("href"):
            return str(link["href"])
    img = BeautifulSoup(summary_html, "html.parser").find("img")
    if isinstance(img, Tag) and img.get("src"):
        return str(img["src"])
    return ""


def entry_published_at(entry: feedparser.FeedParserDict) -> datetime | None:
    """Parse an entry's published date, defaulting to UTC when tz-naive.

    :param entry: Feed entry with a `published` attribute.
    :return: Timezone-aware datetime, or None if unparseable.
    """
    try:
        published = parse_date(translate_weekday(entry.published))
        published_dt = datetime.fromisoformat(published)
    except (AttributeError, ValueError):
        return None
    if published_dt.tzinfo is None:
        published_dt = published_dt.replace(tzinfo=UTC)
    return published_dt


def is_recent_and_readable(published_dt: datetime, title: str) -> bool:
    """Check whether an entry is recent enough and in a supported language.

    :param published_dt: Timezone-aware publish date.
    :param title: Wrapped entry title used for language detection.
    :return: True if the entry should be kept.
    """
    if datetime.now(UTC) - published_dt >= MAX_AGE:
        return False
    try:
        return detect(title) in ("pt", "en")
    except LangDetectException:
        return False


def collect_entries(feed_url: str, source: str) -> list[dict[str, str]]:
    """Fetch one feed and return its filtered, formatted entries.

    :param feed_url: Feed URL to fetch.
    :param source: Human-readable source label for the feed.
    :return: List of entry dicts ready for JSON serialization.
    """
    feed = fetch_feed(feed_url)
    if feed is None:
        return []
    results = []
    for entry in feed.entries:
        summary = entry.summary
        if feed_url == "https://rss.tecmundo.com.br/feed":
            summary = entry.content[0].value
        wrapped_title, wrapped_summary = wrap_and_trim(entry.title, summary)
        published_dt = entry_published_at(entry)
        if published_dt is None:
            continue
        if not is_recent_and_readable(published_dt, wrapped_title):
            continue
        results.append(
            {
                "title": wrapped_title,
                "summary": wrapped_summary,
                "url": entry.link,
                "source": source,
                "published": published_dt.isoformat(),
                "image": extract_image(entry, summary),
            }
        )
    return results


def main() -> None:
    """Fetch every configured feed and write filtered entries to /tmp/rss.json."""
    data: list[dict[str, str]] = []
    for row in RSS_FEEDS:
        logger.info("Parsing RSS feed: %s", row["url"])
        data.extend(collect_entries(row["url"], row["source"]))

    data.sort(key=lambda x: x["published"], reverse=True)
    with open(OUTPUT_PATH, "w", encoding="utf-8") as file:
        file.write(json.dumps(data, ensure_ascii=False))


if __name__ == "__main__":
    main()
