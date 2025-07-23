#!/usr/bin/env python3

import datetime
import re
import subprocess

# ----> EDIT THIS TO MATCH YOUR REPO LOCATION (no trailing slash)
REPO_URL = "https://github.com/LINGOPASS/lingo_intranet_backend"


def run_git_command(command):
    """Runs a git command and returns its output."""
    try:
        result = subprocess.run(command, capture_output=True, text=True, check=True)
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        print(f"Error running git command: {e}")
        print(f"Stderr: {e.stderr}")
        return None


def get_last_tag():
    """Gets the latest Git tag."""
    return run_git_command(["git", "describe", "--tags", "--abbrev=0"])


def get_commits(since_tag=None):
    """
    Gets formatted commit messages.
    Format: hash - subject (author, date)
    """
    if since_tag:
        commit_range = f"{since_tag}..HEAD"
    else:
        commit_range = "HEAD"  # All commits

    command = [
        "git",
        "log",
        "--pretty=format:%h - %s",  # Only hash and subject for parsing
        "--no-merges",
        commit_range,
    ]
    output = run_git_command(command)
    if output:
        return output.splitlines()
    return []


def categorize_commits(commits):
    """Categorizes commits based on conventional commit prefixes."""
    categories = {
        "Features": [],
        "Bug Fixes": [],
        "Documentation": [],
        "Chores": [],
        "Refactoring": [],
        "Other Changes": [],
    }

    for commit_line in commits:
        match = re.match(r"(\w+) - (\w+)(?:\(([^)]+)\))?: (.*)", commit_line)
        if not match:
            categories["Other Changes"].append(commit_line)
            continue

        commit_hash, commit_type, scope, description = match.groups()
        # Clean up description: remove type and scope
        commit_link = f"[{commit_hash}]({REPO_URL}/commit/{commit_hash})"
        clean_description = f"* {description.strip()} ({commit_link})"

        if commit_type == "feat":
            categories["Features"].append(clean_description)
        elif commit_type == "fix":
            categories["Bug Fixes"].append(clean_description)
        elif commit_type == "docs":
            categories["Documentation"].append(clean_description)
        elif commit_type == "chore":
            categories["Chores"].append(clean_description)
        elif commit_type == "refactor":
            categories["Refactoring"].append(clean_description)
        else:
            categories["Other Changes"].append(commit_line)

    return categories


def generate_changelog():
    """Generates the changelog in Markdown format."""
    changelog_content = ["# Changelog", ""]

    last_tag = get_last_tag()
    if last_tag:
        changelog_content.append(
            f"## v{datetime.datetime.now().strftime('%Y.%m.%d')} (Unreleased - based on {last_tag})"
        )
        changelog_content.append("")
        commits = get_commits(since_tag=last_tag)
    else:
        print("Warning: No tags found. Generating changelog from all commits.")
        changelog_content.append(
            f"## v{datetime.datetime.now().strftime('%Y.%m.%d')} (Initial Release / Full History)"
        )
        changelog_content.append("")
        commits = get_commits()

    categorized_commits = categorize_commits(commits)

    # Define order of categories and their titles
    category_order = [
        ("Features", "✨ Features"),
        ("Bug Fixes", "🐛 Bug Fixes"),
        ("Documentation", "📚 Documentation"),
        ("Refactoring", "♻️ Refactoring"),
        ("Chores", "🧹 Chores"),
        ("Other Changes", "🚧 Other Changes"),
    ]

    for category_name, title in category_order:
        if categorized_commits[category_name]:
            changelog_content.append(f"### {title}")
            changelog_content.append("")
            for item in categorized_commits[category_name]:
                changelog_content.append(item)
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
    print("CHANGELOG.md generated successfully.")
