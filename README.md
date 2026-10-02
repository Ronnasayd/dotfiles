# dotfiles

Personal Linux (GNOME) environment: shell, editor, terminal, desktop widgets, helper scripts, git hooks and lint configs. Files stay in this repo; `install.sh` symlinks them into `$HOME`.

## Contents

| Dir / file                                                                                                                                 | What                                                                                      |
| ------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------- |
| `zsh/`                                                                                                                                     | zsh install script, notes (`zsh.md`); `.zshrc`, aliases, functions, completions           |
| `p10k/`                                                                                                                                    | Powerlevel10k prompt                                                                      |
| `tmux/`                                                                                                                                    | tmux config                                                                               |
| `vim/`                                                                                                                                     | vim/neovim config, coc settings, install script                                           |
| `terminator/`                                                                                                                              | Terminator config, theme fix script, color notes                                          |
| `conky/`                                                                                                                                   | Conky widget (theme `MyMimosa`)                                                           |
| `plank/`, `plank-links/`                                                                                                                   | Dock config, theme, `.desktop` launchers                                                  |
| `ulauncher/`                                                                                                                               | Ulauncher settings, shortcuts, extensions                                                 |
| `nemo_actions/`                                                                                                                            | Nemo context-menu actions (open in VS Code, copy path)                                    |
| `gnome/`                                                                                                                                   | `dconf` backup of GNOME settings                                                          |
| `autostart/`                                                                                                                               | Autostart entries (conky, plank)                                                          |
| `asdf/`                                                                                                                                    | `.tool-versions`                                                                          |
| `code-themes/`, `code_extensions/`, `my-custom-vscode-extension/`, `power_vscode/`                                                         | VS Code themes and extensions                                                             |
| `chrome_extensions/`                                                                                                                       | Chrome extensions                                                                         |
| `scripts/`                                                                                                                                 | Helper scripts (installers, QR tools, `save`, `commitai`, wallpaper, system cleanup, ...) |
| `git_hooks/`                                                                                                                               | Conventional-commit `commit-msg`, `pre-commit`, `pre-push`, changelog builder             |
| `.editorconfig`, `.pylintrc`, `.ruff.toml`, `prettier.config.js`, `eslint.config.mjs`, `.golangci.yml`, `.stylelintrc.json`, `.style.yapf` | Lint / format configs                                                                     |
| `AGENTS.md`                                                                                                                                | Canonical instructions for AI coding agents (`CLAUDE.md`, `GEMINI.md` point to it)        |
| `CHANGELOG.md`                                                                                                                             | Generated by `git_hooks/build-changelog.py`                                               |

## Install

```bash
git clone <repo-url> ~/develop/personal/dotfiles
cd ~/develop/personal/dotfiles
bash install.sh
```

`install.sh` must run **from the repo root** (it uses `$(pwd)`). It:

1. Loads the GNOME settings from `gnome/dconf.gnome.bkp` (`dconf load`).
2. Moves existing configs to a backup dir.
3. Symlinks configs into `~` and `~/.config`, scripts into `~/.local/bin`, desktop files into `/usr/share/applications` (needs `sudo`).
4. Copies `eslint.config.mjs` and `prettier.config.js` to `~` (copies, not links).
5. Starts the Conky theme.

> Review the script before running: it moves existing dotfiles and uses `sudo`. Target dirs (`~/.config/nvim`, `~/.local/bin`, `~/.config/autostart`, ...) must exist.

Optional extras: `zsh/zsh.install.sh`, `vim/install.sh`, `scripts/build-system.sh`, `scripts/docker.install.sh`, font scripts (`firacode-nerdfonts.sh`, `jetbrains-mono.sh`, `roboto-font.sh`).

## Scripts

Linked into `~/.local/bin` by the installer:

`colorize-logs`, `qr-server`, `qr-copy`, `save`, `ws`, `commitai`, `change_background`, `pscpu`, `create_python_wrapper`, `curl_headers`.

## Git hooks

Copy or link the files in `git_hooks/` into a repo's `.git/hooks/` (drop the suffix, e.g. `conventional-commits.commit-msg` -> `commit-msg`). Commit messages follow [Conventional Commits](https://www.conventionalcommits.org/).

## Lint / test

```bash
npx eslint .      # JS/TS (eslint.config.mjs)
ruff check .      # Python (.ruff.toml)
pytest            # Python tests (pytest.ini)
```

## AI agents

Rules for Claude Code, Codex, Gemini CLI, Cursor and others live in [`AGENTS.md`](AGENTS.md). Edit that file only.
