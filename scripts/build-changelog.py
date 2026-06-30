"""Generate changelog from Git commit history and tags."""

import datetime
import logging
import re
import subprocess

logger = logging.getLogger(__name__)


def get_repo_url() -> str | None:
    """Get repository URL and convert to web format if needed."""
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
    """Remove emojis from text."""
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
    """Run git command and return output."""
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


def get_last_tag() -> str | None:
    """Get the latest Git tag."""
    return run_git_command(["git", "describe", "--tags", "--abbrev=0"])


def get_commits(since_tag: str | None = None) -> list[str]:
    """Get formatted commit messages.

    Format: hash - subject (author, date).
    """
    commit_range = f"{since_tag}..HEAD" if since_tag else "HEAD"

    # Inclui a data (YYYY-MM-DD) ao final de cada linha
    command = [
        "git",
        "log",
        "--pretty=format:%h - %s | %ad",
        "--date=short",
        "--no-merges",
        commit_range,
    ]
    output = run_git_command(command)
    if output:
        return output.splitlines()
    return []


def categorize_commits(
    commits: list[str], repo_url: str | None
) -> dict[str, list[str]]:
    """Categorize commits based on conventional commit prefixes."""
    # Group by date first, then include category info in each item
    dates: dict[str, list[str]] = {}

    category_emojis = {
        "Features": "✨",
        "Bug Fixes": "🐛",
        "Documentation": "📚",
        "Chores": "🧹",
        "Refactoring": "♻️",
        "Other Changes": "🚧",
    }

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

        match = re.match(r"(\w+) - (\w+)(?:\(([^)]+)\))?: (.*)", commit_main.strip())
        if not match:
            cat = "Other Changes"
            description = commit_line
            commit_hash = ""
        else:
            commit_hash, commit_type, _scope, description = match.groups()
            if commit_type == "feat":
                cat = "Features"
            elif commit_type == "fix":
                cat = "Bug Fixes"
            elif commit_type == "docs":
                cat = "Documentation"
            elif commit_type == "chore":
                cat = "Chores"
            elif commit_type == "refactor":
                cat = "Refactoring"
            else:
                cat = "Other Changes"

        if repo_url and commit_hash:
            commit_link = f"[{commit_hash}]({repo_url}/commit/{commit_hash})"
        else:
            commit_link = ""

        emoji = category_emojis.get(cat, "")
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


def generate_changelog() -> str:
    """Generate changelog in Markdown format."""
    changelog_content = ["# Changelog", ""]

    repo_url = get_repo_url()
    if not repo_url:
        repo_url = None  # fallback, links ficarão sem URL

    last_tag = get_last_tag()
    today = datetime.datetime.now().strftime("%Y.%m.%d")
    if last_tag:
        changelog_content.append(f"## v{today} (Unreleased - based on {last_tag})")
        changelog_content.append("")
        commits = get_commits(since_tag=last_tag)
    else:
        logger.warning("No tags found. Generating changelog from all commits.")
        changelog_content.append(f"## v{today} (Initial Release / Full History)")
        changelog_content.append("")
        commits = get_commits()

    dates_dict = categorize_commits(commits, repo_url)

    # Sort dates in descending order (most recent first)
    for date in sorted(dates_dict.keys(), reverse=True):
        changelog_content.append(f"### **{date}**")
        changelog_content.append("")
        changelog_content.extend(f"- {item}" for item in dates_dict[date])
        changelog_content.append("")

    changelog_content.append("---")
    changelog_content.append(
        f"Generated on {datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}"
    )

    return "\n".join(changelog_content)


if __name__ == "__main__":
    changelog = generate_changelog()
    with open("CHANGELOG.md", "w") as f:
        f.write(changelog)
    logger.info("CHANGELOG.md generated successfully.")
