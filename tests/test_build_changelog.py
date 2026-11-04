"""End-to-end checks for scripts/build-changelog.py against throwaway git repos."""

from pathlib import Path
import subprocess
import tempfile
import unittest

SCRIPT = Path(__file__).resolve().parent.parent / "scripts" / "build-changelog.py"


class BuildChangelogTest(unittest.TestCase):
    def setUp(self) -> None:
        temp_dir = tempfile.TemporaryDirectory()
        self.addCleanup(temp_dir.cleanup)
        self.repo = Path(temp_dir.name)
        self.git("init", "-q")

    def git(self, *args: str) -> None:
        identity = ["-c", "user.name=t", "-c", "user.email=t@example.com"]
        subprocess.run(["git", *identity, *args], cwd=self.repo, check=True)

    def commit(self, message: str) -> None:
        self.git("commit", "-q", "--allow-empty", "-m", message)

    def build_sections(self) -> dict[str, str]:
        """Run the script and map each `## ` heading to the text below it."""
        # hazard: without a shebang, sh runs each `import x` line as ImageMagick's
        # `import`, grabbing the screen. Exec directly so that regression fails here.
        subprocess.run([SCRIPT], cwd=self.repo, check=True)
        changelog = (self.repo / "CHANGELOG.md").read_text()
        sections = changelog.split("\n## ")[1:]
        return dict(section.split("\n", 1) for section in sections)

    def test_documents_every_tag_and_keeps_older_history(self) -> None:
        self.commit("feat: first")
        self.git("tag", "-a", "v1.0.0", "-m", "annotated")
        self.commit("fix: second")
        self.git("tag", "v2.0.0")
        self.commit("docs: third")

        sections = self.build_sections()
        unreleased, newest, oldest = sections
        self.assertIn("(Unreleased - based on v2.0.0)", unreleased)
        self.assertTrue(newest.startswith("v2.0.0"))
        self.assertTrue(oldest.startswith("v1.0.0"))
        self.assertIn("Third", sections[unreleased])
        self.assertIn("Second", sections[newest])
        self.assertIn("First", sections[oldest])
        self.assertNotIn("First", sections[newest])

    def test_tags_sharing_a_commit_get_one_section(self) -> None:
        self.commit("feat: first")
        self.git("tag", "v1.0.0")
        self.git("tag", "stable")

        sections = self.build_sections()
        self.assertEqual(len(sections), 2)
        tagged = list(sections)[1]
        self.assertIn("v1.0.0", tagged)
        self.assertIn("stable", tagged)
        self.assertIn("First", sections[tagged])

    def test_parallel_tags_do_not_repeat_commits(self) -> None:
        self.commit("feat: base")
        self.git("checkout", "-q", "-b", "side")
        self.commit("feat: side")
        self.git("tag", "v1.0.0")
        self.git("checkout", "-q", "-")
        self.commit("feat: main")
        self.git("tag", "v2.0.0")
        self.git("merge", "-q", "--no-ff", "-m", "merge side", "side")

        body = "".join(self.build_sections().values())
        for subject in ("Base", "Side", "Main"):
            self.assertEqual(body.count(subject), 1, subject)

    def test_links_and_categorizes_irregular_subjects(self) -> None:
        self.git("remote", "add", "origin", "git@github.com:owner/repo.git")
        self.commit(" chore(claude): padded")
        self.commit("✨ feat: emoji")
        self.commit("free form message")

        items = next(iter(self.build_sections().values())).splitlines()
        items = [item for item in items if item.startswith("- ")]
        self.assertEqual(len(items), 3)
        for item in items:
            self.assertIn("https://github.com/owner/repo/commit/", item)
            self.assertNotIn(" | ", item)
        self.assertIn("Free form message", items[0])
        self.assertIn("Features]** Emoji", items[1])
        self.assertIn("Chores]** Padded", items[2])

    def test_without_tags_keeps_full_history_section(self) -> None:
        self.commit("feat: first")

        sections = self.build_sections()
        self.assertEqual(len(sections), 1)
        heading = next(iter(sections))
        self.assertIn("(Initial Release / Full History)", heading)
        self.assertIn("First", sections[heading])


if __name__ == "__main__":
    unittest.main()
