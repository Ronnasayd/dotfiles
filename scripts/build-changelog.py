#!/usr/bin/env python3
"""Generate changelog from Git commit history and tags."""

from collections.abc import Sequence
import datetime
import logging
import re
import subprocess

logger = logging.getLogger(__name__)

DEFAULT_CATEGORY = "Other Changes"
COMMIT_CATEGORIES = {
    "feat": "Features",
    "fix": "Bug Fixes",
    "docs": "Documentation",
    "chore": "Chores",
    "refactor": "Refactoring",
}
CATEGORY_EMOJIS = {
    "Features": "✨",
    "Bug Fixes": "🐛",
    "Documentation": "📚",
    "Chores": "🧹",
    "Refactoring": "♻️",
    "Other Changes": "🚧",
}


def get_repo_url() -> str | None:
    """Get repository URL and convert to web format if needed.

    Returns:
        The web URL of the origin remote, or None when it cannot be read.
    """
    url = run_git_command(["git", "config", "--get", "remote.origin.url"])
    if not url:
        logger.warning("Could not obtain repository URL")
        return None
    # Converte SSH para HTTPS se necessário
    if url.endswith(".git"):
        url = url[:-4]
    if url.startswith("git@"):  # Ex: git@github.com:owner/repo.git
        regex = r"git@(?P<host>[^:]+):(?P<owner>[^/]+)/(?P<repo>[^.]+)(?:\.git)?$"
        match = re.search(regex, url)
        if match:
            url = f"https://github.com/{match.group('owner')}/{match.group('repo')}"

    return url


def remove_emojis(text: str) -> str:
    """Remove emojis from text.

    Args:
        text: Text that may contain emojis.

    Returns:
        The text without emojis or surrounding whitespace.
    """
    # Matches characters in the common emoji ranges
    emoji_pattern = re.compile(
        r"["
        r"\U0001f600-\U0001f64f"  # emoticons
        r"\U0001f300-\U0001f5ff"  # symbols & pictographs
        r"\U0001f680-\U0001f6ff"  # transport & map symbols
        r"\U0001f1e0-\U0001f1ff"  # flags (iOS)
        r"\U00002702-\U000027b0"
        r"\U000024c2-\U0001f251"
        r"]+",
        flags=re.UNICODE,
    )
    return emoji_pattern.sub(r"", text).strip()


def run_git_command(command: list[str]) -> str | None:
    """Run git command and return output.

    Args:
        command: The full command line, starting with "git".

    Returns:
        The stripped stdout, or None when the command fails.
    """
    try:
        result = subprocess.run(  # noqa: S603
            command,
            capture_output=True,
            text=True,
            check=True,
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        logger.error("Git command failed: %s", e)
        logger.error("Stderr: %s", e.stderr)
        return None


def get_tag_groups() -> list[tuple[list[str], str]]:
    """List tags reachable from HEAD, newest first.

    Returns:
        One (tag names, commit date) pair per tagged commit.
    """
    # why: version names and tag dates can disagree with the commit graph, which
    # would produce wrong ranges; topological order is the only reliable one.
    command = [
        "git",
        "log",
        "--topo-order",
        "--decorate-refs=refs/tags/",
        "--pretty=format:%as %D",
    ]
    tag_groups = []
    for line in (run_git_command(command) or "").splitlines():
        date, _, decorations = line.partition(" ")
        names = [name.removeprefix("tag: ") for name in decorations.split(", ") if name]
        if names:
            tag_groups.append((names, date))
    return tag_groups


def get_commits(ref: str = "HEAD", excluded_refs: Sequence[str] = ()) -> list[str]:
    """Get formatted commit messages reachable from ref but not from excluded_refs.

    Args:
        ref: Revision to walk back from.
        excluded_refs: Revisions whose history is left out.

    Returns:
        One line per commit, formatted as: hash - subject | date.
    """
    # Inclui a data (YYYY-MM-DD) ao final de cada linha
    command = [
        "git",
        "log",
        "--pretty=format:%h - %s | %ad",
        "--date=short",
        "--no-merges",
        ref,
        *(f"^{excluded_ref}" for excluded_ref in excluded_refs),
    ]
    output = run_git_command(command)
    if output:
        return output.splitlines()
    return []


def parse_subject(subject: str) -> tuple[str, str]:
    """Split a commit subject into changelog category and description.

    Args:
        subject: Commit subject, conventional or free-form.

    Returns:
        The category name and the description without its type prefix.
    """
    # why: real subjects can carry leading spaces or emojis before the type.
    match = re.match(r"\W*(\w+)(?:\([^)]+\))?!?: (.*)", subject)
    if not match:
        return DEFAULT_CATEGORY, subject
    commit_type, description = match.groups()
    return COMMIT_CATEGORIES.get(commit_type, DEFAULT_CATEGORY), description


def categorize_commits(
    commits: list[str], repo_url: str | None
) -> dict[str, list[str]]:
    """Categorize commits based on conventional commit prefixes.

    Args:
        commits: Lines produced by get_commits.
        repo_url: Web URL used to link commits, or None to omit links.

    Returns:
        Formatted changelog items keyed by commit date.
    """
    # Group by date first, then include category info in each item
    dates: dict[str, list[str]] = {}

    for commit_line in commits:
        # commit_line esperado: hash - type(scope): description | YYYY-MM-DD
        # ou: hash - type: description | YYYY-MM-DD
        # ou: hash - mensagem livre | YYYY-MM-DD
        if "|" in commit_line:
            commit_main, commit_date = commit_line.rsplit("|", 1)
            commit_date = commit_date.strip()
        else:
            commit_main = commit_line
            commit_date = "Unknown Date"

        commit_hash, _, subject = commit_main.partition(" - ")
        cat, description = parse_subject(subject)

        if repo_url and commit_hash:
            commit_link = f"[{commit_hash}]({repo_url}/commit/{commit_hash})"
        else:
            commit_link = ""

        emoji = CATEGORY_EMOJIS.get(cat, "")
        clean_description = (
            f"**[{emoji} {cat}]** {remove_emojis(description).capitalize()}"
        )
        if commit_link:
            clean_description += f" ({commit_link})"

        # Group by date first
        if commit_date not in dates:
            dates[commit_date] = []

        dates[commit_date].append(clean_description)

    return dates


def render_commits_by_date(commits: list[str], repo_url: str | None) -> list[str]:
    """Render commits as Markdown lines grouped by date, most recent first.

    Args:
        commits: Lines produced by get_commits.
        repo_url: Web URL used to link commits, or None to omit links.

    Returns:
        The Markdown lines for one changelog section body.
    """
    lines = []
    dates_dict = categorize_commits(commits, repo_url)
    for date in sorted(dates_dict.keys(), reverse=True):
        lines.extend([f"### **{date}**", ""])
        lines.extend(f"- {item}" for item in dates_dict[date])
        lines.append("")
    return lines


def get_sections() -> list[tuple[str, list[str]]]:
    """Collect the changelog sections.

    Returns:
        (heading, commits) pairs: unreleased work, then each tag, newest first.
    """
    tag_groups = get_tag_groups()
    tag_refs = [names[0] for names, _ in tag_groups]
    today = datetime.datetime.now().strftime("%Y.%m.%d")
    if tag_refs:
        heading = f"## v{today} (Unreleased - based on {tag_refs[0]})"
    else:
        logger.warning("No tags found. Generating changelog from all commits.")
        heading = f"## v{today} (Initial Release / Full History)"

    sections = [(heading, get_commits(excluded_refs=tag_refs))]
    for index, (names, date) in enumerate(tag_groups):
        # invariant: excluding every older tag, not only the previous one, keeps
        # commits from tags on parallel branches out of two sections.
        commits = get_commits(names[0], tag_refs[index + 1 :])
        sections.append((f"## {' / '.join(names)} ({date})", commits))
    return sections


def generate_changelog() -> str:
    """Generate changelog in Markdown format.

    Returns:
        The full changelog text.
    """
    changelog_content = ["# Changelog", ""]

    repo_url = get_repo_url()
    if not repo_url:
        repo_url = None  # fallback, links ficarão sem URL

    for heading, commits in get_sections():
        changelog_content.extend([heading, ""])
        changelog_content.extend(render_commits_by_date(commits, repo_url))

    changelog_content.append("---")
    changelog_content.append(
        f"Generated on {datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}"
    )

    return "\n".join(changelog_content)


if __name__ == "__main__":
    changelog = generate_changelog()
    with open("CHANGELOG.md", "w", encoding="utf-8") as f:
        f.write(changelog)
    logger.info("CHANGELOG.md generated successfully.")
