import datetime
import re
import subprocess


def get_repo_url():
    """Obtém a URL do repositório remoto e converte para formato web se necessário."""
    url = run_git_command(["git", "config", "--get", "remote.origin.url"])
    if not url:
        print("Erro: não foi possível obter a URL do repositório remoto.")
        return None
    # Converte SSH para HTTPS se necessário
    if url.endswith(".git"):
        url = url[:-4]
    if url.startswith("git@"):  # Ex: git@github.com:owner/repo.git
        url = url.replace(":", "/").replace("git@", "https://")

    return url


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


def categorize_commits(commits, repo_url):
    """Categorizes commits based on conventional commit prefixes."""
    # Agora, cada categoria será um dict de datas para lista de commits
    categories = {
        "Features": {},
        "Bug Fixes": {},
        "Documentation": {},
        "Chores": {},
        "Refactoring": {},
        "Other Changes": {},
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
            # Agrupa outros por data
            categories["Other Changes"].setdefault(commit_date, []).append(commit_line)
            continue

        commit_hash, commit_type, scope, description = match.groups()
        if repo_url:
            commit_link = f"[{commit_hash}]({repo_url}/commit/{commit_hash})"
        else:
            commit_link = commit_hash
        clean_description = f"* {description.strip().capitalize()} ({commit_link})"

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

        categories[cat].setdefault(commit_date, []).append(clean_description)

    return categories


def generate_changelog():
    """Generates the changelog in Markdown format."""
    changelog_content = ["# Changelog", ""]

    repo_url = get_repo_url()
    if not repo_url:
        repo_url = None  # fallback, links ficarão sem URL

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

    categorized_commits = categorize_commits(commits, repo_url)

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
        category_dict = categorized_commits[category_name]
        if category_dict:
            changelog_content.append(f"### {title}")
            changelog_content.append("")
            # Ordena datas decrescente (mais recente primeiro)
            for date in sorted(category_dict.keys(), reverse=True):
                changelog_content.append(f"**{date}**")
                for item in category_dict[date]:
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
