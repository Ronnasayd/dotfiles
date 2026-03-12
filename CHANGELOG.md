# Changelog

## v2026.03.12 (Unreleased - based on v1.0.5)

### **2026-03-10**

- **[♻️ Refactoring]** Improve commit categorization and changelog generation ([e674ab6](https://github.com/Ronnasayd/dotfiles/commit/e674ab6))
- **[🧹 Chores]** Update changelog for version 2026.03.10 and add new aliases in zsh configuration ([810a149](https://github.com/Ronnasayd/dotfiles/commit/810a149))
- **[🧹 Chores]** Update .gitignore to include github and task management files ([2c8195f](https://github.com/Ronnasayd/dotfiles/commit/2c8195f))

### **2026-03-09**

- **[✨ Features]** Add build-changelog alias to generate changelog from git commit history ([a80cc79](https://github.com/Ronnasayd/dotfiles/commit/a80cc79))
- **[🧹 Chores]** Update project dependencies to latest versions ([d9a365f](https://github.com/Ronnasayd/dotfiles/commit/d9a365f))
- **[✨ Features]** Add new git diff aliases and enhance remote repository functions in zsh configuration ([f79890c](https://github.com/Ronnasayd/dotfiles/commit/f79890c))

### **2026-03-05**

- **[🧹 Chores]** Remove deprecated gemini alias file from zsh configuration ([8422f62](https://github.com/Ronnasayd/dotfiles/commit/8422f62))
- **[✨ Features]** Add loop-video function and new gemini alias file for task management ([a27147f](https://github.com/Ronnasayd/dotfiles/commit/a27147f))

### **2026-02-26**

- **[♻️ Refactoring]** Enhance pre-commit hook to execute tests for affected modules ([cb57f59](https://github.com/Ronnasayd/dotfiles/commit/cb57f59))

### **2026-02-24**

- **[♻️ Refactoring]** Extract microphone and sink variables in monitor-phone.sh for clarity ([f7d91f8](https://github.com/Ronnasayd/dotfiles/commit/f7d91f8))
- **[♻️ Refactoring]** Update audio card profile settings in monitor-phone.sh ([a8381ea](https://github.com/Ronnasayd/dotfiles/commit/a8381ea))

### **2026-02-13**

- **[✨ Features]** Add timeout handling for event fetching in get_events.py and improve error handling in rss_parser.py ([ec07036](https://github.com/Ronnasayd/dotfiles/commit/ec07036))

### **2026-02-12**

- **[✨ Features]** Add logging for valid credentials in get_events.py ([8771caf](https://github.com/Ronnasayd/dotfiles/commit/8771caf))
- **[♻️ Refactoring]** Replace logging with print statements for event fetching in get_events.py ([0b0763f](https://github.com/Ronnasayd/dotfiles/commit/0b0763f))
- **[✨ Features]** Improve event fetching and logging in get_events.py; update alias for column extraction ([631ec43](https://github.com/Ronnasayd/dotfiles/commit/631ec43))

### **2026-01-20**

- **[🧹 Chores]** Remove copilot instructions file ([68707e2](https://github.com/Ronnasayd/dotfiles/commit/68707e2))
- **[✨ Features]** Enhance event handling in get_events.py for timezone awareness and add beekeeper studio desktop entry ([e34cbc8](https://github.com/Ronnasayd/dotfiles/commit/e34cbc8))

### **2025-12-19**

- **[✨ Features]** Update rss script to open current rss feed from a file and modify fd aliases to use fdfind ([ed84c9c](https://github.com/Ronnasayd/dotfiles/commit/ed84c9c))

### **2025-11-27**

- **[🚧 Other Changes]** Update font in network section for improved visual consistency ([9421979](https://github.com/Ronnasayd/dotfiles/commit/9421979))
- **[♻️ Refactoring]** Update calendar dimensions for improved layout in mymimosa theme fix: correct translation shortcut keywords in ulauncher shortcuts ([9110198](https://github.com/Ronnasayd/dotfiles/commit/9110198))

### **2025-11-26**

- **[♻️ Refactoring]** Update calendar width calculation for improved layout adaptability ([2f94246](https://github.com/Ronnasayd/dotfiles/commit/2f94246))

### **2025-11-24**

- **[✨ Features]** Add alias to find application desktop files using fzf ([b78e002](https://github.com/Ronnasayd/dotfiles/commit/b78e002))
- **[✨ Features]** Add support for plex server with docker configuration and additional volume mounts ([4f27077](https://github.com/Ronnasayd/dotfiles/commit/4f27077))

### **2025-11-21**

- **[🧹 Chores]** Update clear-notification icon for improved visual clarity ([3f35ef6](https://github.com/Ronnasayd/dotfiles/commit/3f35ef6))
- **[♻️ Refactoring]** Adjust dimensions and padding for improved layout in mymimosa theme ([d6812f9](https://github.com/Ronnasayd/dotfiles/commit/d6812f9))

### **2025-11-20**

- **[♻️ Refactoring]** Update width and height calculations to use proportional dimensions for improved adaptability ([2624cfc](https://github.com/Ronnasayd/dotfiles/commit/2624cfc))
- **[♻️ Refactoring]** Update dimensions for rings, rss, main, calendar, and player elements in mymimosa theme for improved layout ([1b8a7a0](https://github.com/Ronnasayd/dotfiles/commit/1b8a7a0))
- **[♻️ Refactoring]** Adjust alignment and padding settings for improved layout in mymimosa theme ([9384230](https://github.com/Ronnasayd/dotfiles/commit/9384230))
- **[♻️ Refactoring]** Adjust player dimensions and alignment logic for improved layout in mymimosa theme ([9e91f42](https://github.com/Ronnasayd/dotfiles/commit/9e91f42))
- **[♻️ Refactoring]** Update background image generation dimensions for improved layout in mymimosa theme ([307b1f0](https://github.com/Ronnasayd/dotfiles/commit/307b1f0))
- **[♻️ Refactoring]** Update background dimensions to 1920x1080 and save current background image ([4d9eb77](https://github.com/Ronnasayd/dotfiles/commit/4d9eb77))
- **[♻️ Refactoring]** Update mymimosa theme for improved layout and responsiveness ([b9d8dc0](https://github.com/Ronnasayd/dotfiles/commit/b9d8dc0))
- **[♻️ Refactoring]** Improve layout and positioning of conky background elements in mymimosa theme ([d0af13a](https://github.com/Ronnasayd/dotfiles/commit/d0af13a))
- **[✨ Features]** Add system info alias and implement monitor-phone script for audio jack events ([a6fd339](https://github.com/Ronnasayd/dotfiles/commit/a6fd339))

### **2025-11-19**

- **[♻️ Refactoring]** Update conky configuration for improved layout and dynamic sizing ([7d7edc3](https://github.com/Ronnasayd/dotfiles/commit/7d7edc3))
- **[✨ Features]** Add auto-expand functionality for vscode sidebar based on width ([875dbd8](https://github.com/Ronnasayd/dotfiles/commit/875dbd8))
- **[🐛 Bug Fixes]** Replace apt-get with apt for package installation in build-system.sh ([ff118b8](https://github.com/Ronnasayd/dotfiles/commit/ff118b8))
- **[🐛 Bug Fixes]** Install imagemagick in set_trash_icons.sh and update fzf command in .zshrc ([4b3a088](https://github.com/Ronnasayd/dotfiles/commit/4b3a088))

### **2025-11-17**

- **[🐛 Bug Fixes]** Update background darkness in tokyonight profile and adjust fzf command in zsh configuration ([7c1c83d](https://github.com/Ronnasayd/dotfiles/commit/7c1c83d))

### **2025-11-16**

- **[✨ Features]** Add autostart entries for conky, plank, and ulauncher applications ([2ca0300](https://github.com/Ronnasayd/dotfiles/commit/2ca0300))
- **[🐛 Bug Fixes]** Adjust conky theme layout and update zsh configuration for asdf_dir path ([7f7a645](https://github.com/Ronnasayd/dotfiles/commit/7f7a645))
- **[✨ Features]** Add roboto font installation script and update conky theme dimensions and settings ([7517d21](https://github.com/Ronnasayd/dotfiles/commit/7517d21))
- **[🧹 Chores]** Update file permissions for firacode and jetbrains mono installation scripts ([5ff5e43](https://github.com/Ronnasayd/dotfiles/commit/5ff5e43))
- **[🧹 Chores]** Update launcher paths in plank dock items and add new items for home and downloads ([df4ba7f](https://github.com/Ronnasayd/dotfiles/commit/df4ba7f))

### **2025-11-15**

- **[🧹 Chores]** Update scripts to source python virtual environment for conky themes ([d886b91](https://github.com/Ronnasayd/dotfiles/commit/d886b91))
- **[🐛 Bug Fixes]** Update docker installation script for gpg key handling and modify ulauncher settings and extensions timestamps ([6a533e6](https://github.com/Ronnasayd/dotfiles/commit/6a533e6))
- **[✨ Features]** Add installation scripts for firacode and jetbrains mono nerd fonts, and update build system script ([f6867d9](https://github.com/Ronnasayd/dotfiles/commit/f6867d9))

### **2025-10-31**

- **[🧹 Chores]** Add docker installation step to build system script ([c01d001](https://github.com/Ronnasayd/dotfiles/commit/c01d001))
- **[♻️ Refactoring]** Update installation scripts to modularize package installations ([54731e8](https://github.com/Ronnasayd/dotfiles/commit/54731e8))
- **[🧹 Chores]** Update icons ([27c79c4](https://github.com/Ronnasayd/dotfiles/commit/27c79c4))

### **2025-10-29**

- **[🐛 Bug Fixes]** Correctly convert git@ urls to https in build-changelog script ([670b5db](https://github.com/Ronnasayd/dotfiles/commit/670b5db))
- **[♻️ Refactoring]** Update remote git repository functions and aliases, and use python3 in wrapper script ([6f1ed01](https://github.com/Ronnasayd/dotfiles/commit/6f1ed01))
- **[♻️ Refactoring]** Update commit description formatting to capitalize first letter ([95fba8f](https://github.com/Ronnasayd/dotfiles/commit/95fba8f))
- **[♻️ Refactoring]** Enhance changelog generation to include commit dates and categorize by date ([e346611](https://github.com/Ronnasayd/dotfiles/commit/e346611))
- **[♻️ Refactoring]** Update changelog and wrapper scripts for dynamic repo url and optional venv - add `get_repo_url()` to fetch the remote url, convert ssh to https, and strip `.git`. - pass the repo url to `categorize_commits()` so commit links use the correct base url. - gracefully handle missing repo urls by falling back to plain commit hashes. - enhance `create_python_wrapper.sh` to allow skipping a virtual‑env, prompt for a path, and create wrappers with or without `source venv/bin/activate`. - update the zsh alias to point to `~/.local/bin/create_python_wrapper`. ([79c430f](https://github.com/Ronnasayd/dotfiles/commit/79c430f))
- **[🐛 Bug Fixes]** Update event formatting in get_events.py and enhance offset handling in my.handle.lua ([6f6043a](https://github.com/Ronnasayd/dotfiles/commit/6f6043a))

### **2025-10-28**

- **[✨ Features]** Add aria-download function and alias, echo ffmpeg commands in m3u-download ([3be76ce](https://github.com/Ronnasayd/dotfiles/commit/3be76ce))

### **2025-10-24**

- **[🐛 Bug Fixes]** Update real_max value in settings_table for accuracy ([47e0645](https://github.com/Ronnasayd/dotfiles/commit/47e0645))
- **[🐛 Bug Fixes]** Update ring parameters for improved visual consistency ([59b6fc4](https://github.com/Ronnasayd/dotfiles/commit/59b6fc4))
- **[🐛 Bug Fixes]** Update draw_ring function to improve cpu frequency display and rename conky_cpu_freq_mean for clarity ([490abce](https://github.com/Ronnasayd/dotfiles/commit/490abce))
- **[🐛 Bug Fixes]** Correct suffix formatting and improve text positioning in draw_ring function ([977a36f](https://github.com/Ronnasayd/dotfiles/commit/977a36f))
- **[♻️ Refactoring]** Refactor code structure for improved readability and maintainability ([ca050a2](https://github.com/Ronnasayd/dotfiles/commit/ca050a2))

### **2025-10-22**

- **[🧹 Chores]** Update extensions list, settings, and shortcuts - remove obsolete extensions from `extensions.json` - increase `show-recent-apps` count from 4 to 5 in `settings.json` - add new shortcuts for `gpt` and `whats` in `shortcuts.json` ([c672ef4](https://github.com/Ronnasayd/dotfiles/commit/c672ef4))

### **2025-10-21**

- **[♻️ Refactoring]** Rename zsh aliases and functions to descriptive names and add strip_colors helper - update `.alias.zshrc` ([0665964](https://github.com/Ronnasayd/dotfiles/commit/0665964))

### **2025-09-30**

- **[✨ Features]** Update zsh aliases and functions for improved usability and integration - enhanced alias definitions for docker and video processing commands, adding function notations for clarity. - improved commit message generation process in `copilot_commit` function by utilizing a temporary commit file for better handling. - added task master aliases for easier task management. ([633e895](https://github.com/Ronnasayd/dotfiles/commit/633e895))

### **2025-09-09**

- **[🐛 Bug Fixes]** Update copilot_commit function to directly commit changes without echoing commit message ([b8f4c71](https://github.com/Ronnasayd/dotfiles/commit/b8f4c71))
- **[✨ Features]** Add copilot_commit function to generate commit messages using github copilot based on staged changes ([b53b263](https://github.com/Ronnasayd/dotfiles/commit/b53b263))
- **[♻️ Refactoring]** Improve commit_ai.py system and user messages with detailed conventional commits guidelines ([3f90952](https://github.com/Ronnasayd/dotfiles/commit/3f90952))

### **2025-09-08**

- **[✨ Features]** Add new aliases for creating python wrappers and displaying cpu usage ([f27fa4c](https://github.com/Ronnasayd/dotfiles/commit/f27fa4c))

### **2025-09-07**

- **[✨ Features]** Add alias for fetching http headers using curl ([0375436](https://github.com/Ronnasayd/dotfiles/commit/0375436))
- **[✨ Features]** Add symlinks for new python scripts in install.sh and update aliases in .alias.zshrc ([76103c5](https://github.com/Ronnasayd/dotfiles/commit/76103c5))
- **[✨ Features]** Add scripts for creating python wrappers and extracting curl headers from clipboard ([0b24209](https://github.com/Ronnasayd/dotfiles/commit/0b24209))
- **[📚 Documentation]** Add comprehensive instructions for github copilot usage and development workflow ([139d0ed](https://github.com/Ronnasayd/dotfiles/commit/139d0ed))

### **2025-08-29**

- **[♻️ Refactoring]** Refactor code structure for improved readability and maintainability ([dc8b087](https://github.com/Ronnasayd/dotfiles/commit/dc8b087))

### **2025-08-26**

- **[✨ Features]** Add clipboard save script add a new `scripts/save.sh` that exports the clipboard to a file (png, json, or plain text). symlink the script in `install.sh` and create an empty `gemini.md` placeholder. ([5d77309](https://github.com/Ronnasayd/dotfiles/commit/5d77309))

### **2025-08-23**

- **[♻️ Refactoring]** Enhance shell configuration - add `work.github.com` host to ssh config - add `gemini` alias with correct node version - replace `grep` with `ag` in `find-text` for faster searches - add `gopath_link` helper and override `dep` for gopath projects - add `copy` function to copy file contents or paths to clipboard - set `gopath` and prepend it to `path` in `.zshrc` - minor clean‑ups and comments in shell functions. ([136b087](https://github.com/Ronnasayd/dotfiles/commit/136b087))

### **2025-08-12**

- **[♻️ Refactoring]** Make commit_ai script robust by detecting repo root, loading env from .secrets, and running git commands in the correct working directory. ([2e510b2](https://github.com/Ronnasayd/dotfiles/commit/2e510b2))

### **2025-08-08**

- **[♻️ Refactoring]** Update commit_ai.py to use english prompts and clean up formatting - remove unnecessary blank line after imports - translate system and user messages to english - add explicit instruction to follow conventional commits format and allowed prefixes - minor whitespace adjustments for consistency ([f90d7ef](https://github.com/Ronnasayd/dotfiles/commit/f90d7ef))
- **[🧹 Chores]** Remove obsolete context/coverage scripts and update cows alias to exit after opening vs code - delete `scripts/generate-context-ia.py` and `scripts/generate-coverage-ia.py` (no longer used). - update `zsh/.alias.zshrc` to run `cows && exit` so the terminal closes after opening a workspace. ([a7d36bf](https://github.com/Ronnasayd/dotfiles/commit/a7d36bf))
- **[✨ Features]** Add commitai script and remove obsolete generate scripts - create executable `scripts/commit_ai.py` and symlink it to `~/.local/bin/commitai`. - remove symlinks for `generate-context-ia.py` and `generate-coverage-ia.py` from the install script. ([1cacb1c](https://github.com/Ronnasayd/dotfiles/commit/1cacb1c))
- **[✨ Features]** Add commit_ai.py script for ai‑generated commit messages ([89b5309](https://github.com/Ronnasayd/dotfiles/commit/89b5309))

### **2025-08-05**

- **[♻️ Refactoring]** Update ([123db4b](https://github.com/Ronnasayd/dotfiles/commit/123db4b))
- **[♻️ Refactoring]** Update ([5f7a843](https://github.com/Ronnasayd/dotfiles/commit/5f7a843))

### **2025-08-02**

- **[♻️ Refactoring]** Update ([ec8f9fd](https://github.com/Ronnasayd/dotfiles/commit/ec8f9fd))

### **2025-08-01**

- **[♻️ Refactoring]** Update ([dc4c602](https://github.com/Ronnasayd/dotfiles/commit/dc4c602))
- **[♻️ Refactoring]** Update ([b38a376](https://github.com/Ronnasayd/dotfiles/commit/b38a376))

### **2025-07-31**

- **[♻️ Refactoring]** Update ([42ecc63](https://github.com/Ronnasayd/dotfiles/commit/42ecc63))

### **2025-07-29**

- **[♻️ Refactoring]** Update ([65bde16](https://github.com/Ronnasayd/dotfiles/commit/65bde16))

### **2025-07-26**

- **[♻️ Refactoring]** Update ([dea597e](https://github.com/Ronnasayd/dotfiles/commit/dea597e))
- **[♻️ Refactoring]** Update ([1bebf83](https://github.com/Ronnasayd/dotfiles/commit/1bebf83))
- **[♻️ Refactoring]** Update ([f97c31e](https://github.com/Ronnasayd/dotfiles/commit/f97c31e))
- **[♻️ Refactoring]** Udpdate ([451fd67](https://github.com/Ronnasayd/dotfiles/commit/451fd67))
- **[♻️ Refactoring]** Update ([45e6cc1](https://github.com/Ronnasayd/dotfiles/commit/45e6cc1))

### **2025-07-25**

- **[♻️ Refactoring]** Update ([73ac501](https://github.com/Ronnasayd/dotfiles/commit/73ac501))

### **2025-07-24**

- **[♻️ Refactoring]** Update ([f24d134](https://github.com/Ronnasayd/dotfiles/commit/f24d134))
- **[♻️ Refactoring]** Generate context to ia ([c41b033](https://github.com/Ronnasayd/dotfiles/commit/c41b033))

### **2025-07-23**

- **[♻️ Refactoring]** Update ([5981d67](https://github.com/Ronnasayd/dotfiles/commit/5981d67))

### **2025-07-21**

- **[♻️ Refactoring]** Update ([d61599d](https://github.com/Ronnasayd/dotfiles/commit/d61599d))

### **2025-07-20**

- **[♻️ Refactoring]** Update ([a10d4aa](https://github.com/Ronnasayd/dotfiles/commit/a10d4aa))
- **[♻️ Refactoring]** Remove languages ([3662826](https://github.com/Ronnasayd/dotfiles/commit/3662826))

### **2025-07-19**

- **[♻️ Refactoring]** Update ([91161c7](https://github.com/Ronnasayd/dotfiles/commit/91161c7))

### **2025-07-17**

- **[♻️ Refactoring]** Update ([9e421a6](https://github.com/Ronnasayd/dotfiles/commit/9e421a6))

### **2025-07-16**

- **[♻️ Refactoring]** Update ([0d4886b](https://github.com/Ronnasayd/dotfiles/commit/0d4886b))

### **2025-07-14**

- **[♻️ Refactoring]** Update ([5386576](https://github.com/Ronnasayd/dotfiles/commit/5386576))
- **[♻️ Refactoring]** Update ([d2f09b5](https://github.com/Ronnasayd/dotfiles/commit/d2f09b5))
- **[♻️ Refactoring]** Update ([a8d0464](https://github.com/Ronnasayd/dotfiles/commit/a8d0464))
- **[♻️ Refactoring]** Update ([e51bffd](https://github.com/Ronnasayd/dotfiles/commit/e51bffd))
- **[♻️ Refactoring]** Update ([5071e12](https://github.com/Ronnasayd/dotfiles/commit/5071e12))

### **2025-07-12**

- **[♻️ Refactoring]** Update ([4fa2a04](https://github.com/Ronnasayd/dotfiles/commit/4fa2a04))
- **[♻️ Refactoring]** Update ([1924d84](https://github.com/Ronnasayd/dotfiles/commit/1924d84))
- **[♻️ Refactoring]** Updates ([232952c](https://github.com/Ronnasayd/dotfiles/commit/232952c))

### **2025-07-10**

- **[♻️ Refactoring]** Update ([2a915b8](https://github.com/Ronnasayd/dotfiles/commit/2a915b8))
- **[♻️ Refactoring]** Update ([fcc6137](https://github.com/Ronnasayd/dotfiles/commit/fcc6137))

### **2025-07-08**

- **[♻️ Refactoring]** Update ([4646b50](https://github.com/Ronnasayd/dotfiles/commit/4646b50))

### **2025-07-05**

- **[♻️ Refactoring]** Update ([4fcbd1a](https://github.com/Ronnasayd/dotfiles/commit/4fcbd1a))

### **2025-07-04**

- **[♻️ Refactoring]** Update ([5521848](https://github.com/Ronnasayd/dotfiles/commit/5521848))
- **[♻️ Refactoring]** Update ([ae94c04](https://github.com/Ronnasayd/dotfiles/commit/ae94c04))
- **[♻️ Refactoring]** Update ([6abf378](https://github.com/Ronnasayd/dotfiles/commit/6abf378))

### **2025-07-03**

- **[♻️ Refactoring]** Update ([8004e54](https://github.com/Ronnasayd/dotfiles/commit/8004e54))
- **[♻️ Refactoring]** Update ([5aad049](https://github.com/Ronnasayd/dotfiles/commit/5aad049))

### **2025-07-02**

- **[♻️ Refactoring]** Update ([3e92979](https://github.com/Ronnasayd/dotfiles/commit/3e92979))
- **[♻️ Refactoring]** Update ([8424092](https://github.com/Ronnasayd/dotfiles/commit/8424092))
- **[♻️ Refactoring]** Update ([5c4594f](https://github.com/Ronnasayd/dotfiles/commit/5c4594f))

### **2025-07-01**

- **[♻️ Refactoring]** Update ([0278b94](https://github.com/Ronnasayd/dotfiles/commit/0278b94))
- **[♻️ Refactoring]** Add bat ([e6438b6](https://github.com/Ronnasayd/dotfiles/commit/e6438b6))
- **[♻️ Refactoring]** Add zoxide ([d844bb4](https://github.com/Ronnasayd/dotfiles/commit/d844bb4))
- **[♻️ Refactoring]** Update ([dfe2959](https://github.com/Ronnasayd/dotfiles/commit/dfe2959))

### **2025-06-30**

- **[♻️ Refactoring]** Revert colorize logs ([65d60a7](https://github.com/Ronnasayd/dotfiles/commit/65d60a7))
- **[♻️ Refactoring]** Add suport to json and object to colorize ([f098156](https://github.com/Ronnasayd/dotfiles/commit/f098156))

### **2025-06-28**

- **[♻️ Refactoring]** Update ([e029ea7](https://github.com/Ronnasayd/dotfiles/commit/e029ea7))

### **2025-06-27**

- **[♻️ Refactoring]** Update ([739fc43](https://github.com/Ronnasayd/dotfiles/commit/739fc43))
- **[♻️ Refactoring]** Update ([1435546](https://github.com/Ronnasayd/dotfiles/commit/1435546))
- **[♻️ Refactoring]** Update ([d55bb57](https://github.com/Ronnasayd/dotfiles/commit/d55bb57))

### **2025-06-26**

- **[♻️ Refactoring]** Update ([72e9860](https://github.com/Ronnasayd/dotfiles/commit/72e9860))
- **[♻️ Refactoring]** Update ([5cf39e1](https://github.com/Ronnasayd/dotfiles/commit/5cf39e1))
- **[♻️ Refactoring]** Update ([7a27dc3](https://github.com/Ronnasayd/dotfiles/commit/7a27dc3))
- **[♻️ Refactoring]** Remove load issue ([5ca7af8](https://github.com/Ronnasayd/dotfiles/commit/5ca7af8))

### **2025-06-25**

- **[♻️ Refactoring]** Update ([210662e](https://github.com/Ronnasayd/dotfiles/commit/210662e))
- **[♻️ Refactoring]** Update ([fd788a3](https://github.com/Ronnasayd/dotfiles/commit/fd788a3))
- **[♻️ Refactoring]** Update ([51a429f](https://github.com/Ronnasayd/dotfiles/commit/51a429f))
- **[♻️ Refactoring]** Update ([d8dd10b](https://github.com/Ronnasayd/dotfiles/commit/d8dd10b))
- **[♻️ Refactoring]** Update ([b7ce377](https://github.com/Ronnasayd/dotfiles/commit/b7ce377))
- **[♻️ Refactoring]** Update ([bce4ee5](https://github.com/Ronnasayd/dotfiles/commit/bce4ee5))

### **2025-06-24**

- **[♻️ Refactoring]** Update ([b3b9d7d](https://github.com/Ronnasayd/dotfiles/commit/b3b9d7d))
- **[♻️ Refactoring]** Update location ([95538ba](https://github.com/Ronnasayd/dotfiles/commit/95538ba))

### **2025-06-23**

- **[♻️ Refactoring]** Update ([f69a496](https://github.com/Ronnasayd/dotfiles/commit/f69a496))
- **[♻️ Refactoring]** Update ([68c45c4](https://github.com/Ronnasayd/dotfiles/commit/68c45c4))
- **[♻️ Refactoring]** Update ([0e183bf](https://github.com/Ronnasayd/dotfiles/commit/0e183bf))

### **2025-06-21**

- **[♻️ Refactoring]** Update ([05b7b73](https://github.com/Ronnasayd/dotfiles/commit/05b7b73))
- **[♻️ Refactoring]** Update ([47ac53b](https://github.com/Ronnasayd/dotfiles/commit/47ac53b))
- **[♻️ Refactoring]** Add change-background ([f36cd90](https://github.com/Ronnasayd/dotfiles/commit/f36cd90))
- **[♻️ Refactoring]** Optimize background ([f56c584](https://github.com/Ronnasayd/dotfiles/commit/f56c584))

### **2025-06-20**

- **[♻️ Refactoring]** Update ([b06e765](https://github.com/Ronnasayd/dotfiles/commit/b06e765))
- **[♻️ Refactoring]** Add blur in conky ([c56b107](https://github.com/Ronnasayd/dotfiles/commit/c56b107))

### **2025-06-18**

- **[♻️ Refactoring]** Update ([0f5d9df](https://github.com/Ronnasayd/dotfiles/commit/0f5d9df))
- **[♻️ Refactoring]** Update ([fab1aae](https://github.com/Ronnasayd/dotfiles/commit/fab1aae))

### **2025-06-12**

- **[♻️ Refactoring]** Add pscpu ([8baca00](https://github.com/Ronnasayd/dotfiles/commit/8baca00))

### **2025-06-11**

- **[♻️ Refactoring]** Update ([f077645](https://github.com/Ronnasayd/dotfiles/commit/f077645))

### **2025-05-23**

- **[♻️ Refactoring]** Update ([13edf90](https://github.com/Ronnasayd/dotfiles/commit/13edf90))

### **2025-05-22**

- **[♻️ Refactoring]** Update ([ec142f3](https://github.com/Ronnasayd/dotfiles/commit/ec142f3))

### **2025-05-09**

- **[♻️ Refactoring]** Add code-themes ([ee201c2](https://github.com/Ronnasayd/dotfiles/commit/ee201c2))

### **2025-04-14**

- **[♻️ Refactoring]** Updates ([3962042](https://github.com/Ronnasayd/dotfiles/commit/3962042))

### **2025-03-13**

- **[♻️ Refactoring]** Update ([4e63695](https://github.com/Ronnasayd/dotfiles/commit/4e63695))

### **2025-03-10**

- **[♻️ Refactoring]** Update ([f5a1376](https://github.com/Ronnasayd/dotfiles/commit/f5a1376))

### **2025-03-08**

- **[♻️ Refactoring]** Update ([7909ef8](https://github.com/Ronnasayd/dotfiles/commit/7909ef8))
- **[♻️ Refactoring]** Update ([796f7b8](https://github.com/Ronnasayd/dotfiles/commit/796f7b8))
- **[♻️ Refactoring]** Udpate ([2675a08](https://github.com/Ronnasayd/dotfiles/commit/2675a08))

### **2025-03-07**

- **[♻️ Refactoring]** Update ([5f5fc2a](https://github.com/Ronnasayd/dotfiles/commit/5f5fc2a))
- **[♻️ Refactoring]** Update ([f6c59d6](https://github.com/Ronnasayd/dotfiles/commit/f6c59d6))

### **2025-02-25**

- **[♻️ Refactoring]** Update ([d4f6c2d](https://github.com/Ronnasayd/dotfiles/commit/d4f6c2d))

### **2025-02-24**

- **[♻️ Refactoring]** Update ([c6d8f95](https://github.com/Ronnasayd/dotfiles/commit/c6d8f95))

### **2025-02-20**

- **[♻️ Refactoring]** Update ([9e5ada3](https://github.com/Ronnasayd/dotfiles/commit/9e5ada3))
- **[♻️ Refactoring]** Update ([1146465](https://github.com/Ronnasayd/dotfiles/commit/1146465))
- **[♻️ Refactoring]** Update ([f484880](https://github.com/Ronnasayd/dotfiles/commit/f484880))

### **2025-02-19**

- **[♻️ Refactoring]** Update ([2c6e65b](https://github.com/Ronnasayd/dotfiles/commit/2c6e65b))

### **2025-02-17**

- **[♻️ Refactoring]** Update ([f4e1edd](https://github.com/Ronnasayd/dotfiles/commit/f4e1edd))
- **[♻️ Refactoring]** Update ([fd2213c](https://github.com/Ronnasayd/dotfiles/commit/fd2213c))

### **2025-02-14**

- **[♻️ Refactoring]** Update ([cd554eb](https://github.com/Ronnasayd/dotfiles/commit/cd554eb))

### **2025-02-12**

- **[♻️ Refactoring]** Update ([abe5893](https://github.com/Ronnasayd/dotfiles/commit/abe5893))

### **2025-02-11**

- **[♻️ Refactoring]** Update ([ea97250](https://github.com/Ronnasayd/dotfiles/commit/ea97250))

### **2025-02-10**

- **[♻️ Refactoring]** Update ([824f4b4](https://github.com/Ronnasayd/dotfiles/commit/824f4b4))
- **[♻️ Refactoring]** Update ([fecc4d5](https://github.com/Ronnasayd/dotfiles/commit/fecc4d5))

### **2025-02-04**

- **[♻️ Refactoring]** Update ([1c746f1](https://github.com/Ronnasayd/dotfiles/commit/1c746f1))
- **[♻️ Refactoring]** Update ([2240786](https://github.com/Ronnasayd/dotfiles/commit/2240786))

### **2025-02-03**

- **[♻️ Refactoring]** Update ([34b8aa9](https://github.com/Ronnasayd/dotfiles/commit/34b8aa9))

### **2025-01-09**

- **[♻️ Refactoring]** Update openrb ([e733401](https://github.com/Ronnasayd/dotfiles/commit/e733401))
- **[♻️ Refactoring]** Update ([de4b029](https://github.com/Ronnasayd/dotfiles/commit/de4b029))

### **2024-12-18**

- **[♻️ Refactoring]** Update ([e8383ef](https://github.com/Ronnasayd/dotfiles/commit/e8383ef))
- **[♻️ Refactoring]** Update ([d26f9bb](https://github.com/Ronnasayd/dotfiles/commit/d26f9bb))

### **2024-12-12**

- **[♻️ Refactoring]** Update ([54393aa](https://github.com/Ronnasayd/dotfiles/commit/54393aa))
- **[♻️ Refactoring]** Adjust editorconfig ([711a7f1](https://github.com/Ronnasayd/dotfiles/commit/711a7f1))

### **2024-12-11**

- **[♻️ Refactoring]** Update ([0e23291](https://github.com/Ronnasayd/dotfiles/commit/0e23291))

### **2024-12-10**

- **[♻️ Refactoring]** Update find-text function ([b3bbd74](https://github.com/Ronnasayd/dotfiles/commit/b3bbd74))
- **[✨ Features]** Add qr-server ([2b137e4](https://github.com/Ronnasayd/dotfiles/commit/2b137e4))

### **2024-12-09**

- **[♻️ Refactoring]** Update ([2305fdf](https://github.com/Ronnasayd/dotfiles/commit/2305fdf))
- **[♻️ Refactoring]** Update ([275f07d](https://github.com/Ronnasayd/dotfiles/commit/275f07d))
- **[♻️ Refactoring]** Update ([ba2ab1e](https://github.com/Ronnasayd/dotfiles/commit/ba2ab1e))
- **[♻️ Refactoring]** Update ([afb7319](https://github.com/Ronnasayd/dotfiles/commit/afb7319))

### **2024-12-07**

- **[♻️ Refactoring]** Update extensions ([a51cb3c](https://github.com/Ronnasayd/dotfiles/commit/a51cb3c))
- **[♻️ Refactoring]** Update conky ([aa0f1a7](https://github.com/Ronnasayd/dotfiles/commit/aa0f1a7))
- **[🧹 Chores]** Adjusting comments ([8422ed2](https://github.com/Ronnasayd/dotfiles/commit/8422ed2))
- **[✨ Features]** Add function to copy with exclusion ([258f304](https://github.com/Ronnasayd/dotfiles/commit/258f304))

### **2024-12-06**

- **[🧹 Chores]** Remove dockitens ([1615dd7](https://github.com/Ronnasayd/dotfiles/commit/1615dd7))
- **[♻️ Refactoring]** Adjust for delete file ([e47e289](https://github.com/Ronnasayd/dotfiles/commit/e47e289))
- **[♻️ Refactoring]** Update theme ([04cc9d4](https://github.com/Ronnasayd/dotfiles/commit/04cc9d4))
- **[♻️ Refactoring]** Adjust theme for plank and conky ([983a4a5](https://github.com/Ronnasayd/dotfiles/commit/983a4a5))
- **[♻️ Refactoring]** Update ([26fda8c](https://github.com/Ronnasayd/dotfiles/commit/26fda8c))

### **2024-12-03**

- **[♻️ Refactoring]** Refactoring public ip ([c969a4c](https://github.com/Ronnasayd/dotfiles/commit/c969a4c))
- **[♻️ Refactoring]** Add coc extensions ([b465e49](https://github.com/Ronnasayd/dotfiles/commit/b465e49))

### **2024-11-29**

- **[♻️ Refactoring]** Add color picker ([573e72b](https://github.com/Ronnasayd/dotfiles/commit/573e72b))
- **[♻️ Refactoring]** Adjust colors ([f821121](https://github.com/Ronnasayd/dotfiles/commit/f821121))
- **[♻️ Refactoring]** Adjusts ([74359ce](https://github.com/Ronnasayd/dotfiles/commit/74359ce))
- **[🧹 Chores]** Add icons ([cb5fb73](https://github.com/Ronnasayd/dotfiles/commit/cb5fb73))

### **2024-11-28**

- **[♻️ Refactoring]** Adjusts ([7f1eec6](https://github.com/Ronnasayd/dotfiles/commit/7f1eec6))

### **2024-11-27**

- **[✨ Features]** Add colorize-logs ([bf154cb](https://github.com/Ronnasayd/dotfiles/commit/bf154cb))
- **[♻️ Refactoring]** Rename functions ([c8bf1ae](https://github.com/Ronnasayd/dotfiles/commit/c8bf1ae))
- **[🧹 Chores]** Split aliases and functions ([04bc976](https://github.com/Ronnasayd/dotfiles/commit/04bc976))
- **[♻️ Refactoring]** Adjust at icons ([2a42cd7](https://github.com/Ronnasayd/dotfiles/commit/2a42cd7))
- **[🧹 Chores]** Add icon ([b70ce2a](https://github.com/Ronnasayd/dotfiles/commit/b70ce2a))

### **2024-11-26**

- **[🧹 Chores]** Add extension ([3fe8971](https://github.com/Ronnasayd/dotfiles/commit/3fe8971))
- **[♻️ Refactoring]** Change configs ([b019863](https://github.com/Ronnasayd/dotfiles/commit/b019863))
- **[♻️ Refactoring]** Change hotkey ([de8ca58](https://github.com/Ronnasayd/dotfiles/commit/de8ca58))
- **[♻️ Refactoring]** Update ([cf517b7](https://github.com/Ronnasayd/dotfiles/commit/cf517b7))
- **[♻️ Refactoring]** Adjusts ([786c06f](https://github.com/Ronnasayd/dotfiles/commit/786c06f))
- **[♻️ Refactoring]** Update ([21160fd](https://github.com/Ronnasayd/dotfiles/commit/21160fd))
- **[♻️ Refactoring]** Update ([db0a65d](https://github.com/Ronnasayd/dotfiles/commit/db0a65d))
- **[♻️ Refactoring]** Update ([42ddc3e](https://github.com/Ronnasayd/dotfiles/commit/42ddc3e))

### **2024-11-25**

- **[♻️ Refactoring]** Clear notifications ([fb7f37d](https://github.com/Ronnasayd/dotfiles/commit/fb7f37d))
- **[♻️ Refactoring]** Update ([254796e](https://github.com/Ronnasayd/dotfiles/commit/254796e))
- **[🐛 Bug Fixes]** Adjust command ([465fec1](https://github.com/Ronnasayd/dotfiles/commit/465fec1))

### **2024-11-23**

- **[✨ Features]** Add custom scripts ([8feb913](https://github.com/Ronnasayd/dotfiles/commit/8feb913))
- **[♻️ Refactoring]** Add godot ([cf30221](https://github.com/Ronnasayd/dotfiles/commit/cf30221))
- **[🧹 Chores]** Update ([42a9413](https://github.com/Ronnasayd/dotfiles/commit/42a9413))

### **2024-11-22**

- **[🧹 Chores]** Update extensions ([8e653eb](https://github.com/Ronnasayd/dotfiles/commit/8e653eb))
- **[✨ Features]** Add force pip3 install ([3622fde](https://github.com/Ronnasayd/dotfiles/commit/3622fde))

### **2024-11-21**

- **[♻️ Refactoring]** Update extensions ([eab982a](https://github.com/Ronnasayd/dotfiles/commit/eab982a))
- **[♻️ Refactoring]** Update ([b750224](https://github.com/Ronnasayd/dotfiles/commit/b750224))
- **[✨ Features]** Add ssh config ([62b801a](https://github.com/Ronnasayd/dotfiles/commit/62b801a))
- **[♻️ Refactoring]** Update ([6fd9b90](https://github.com/Ronnasayd/dotfiles/commit/6fd9b90))
- **[✨ Features]** Add ulauncher configs ([3b94711](https://github.com/Ronnasayd/dotfiles/commit/3b94711))
- **[🧹 Chores]** Update install ([b725615](https://github.com/Ronnasayd/dotfiles/commit/b725615))
- **[♻️ Refactoring]** Update ([927afff](https://github.com/Ronnasayd/dotfiles/commit/927afff))

### **2024-11-20**

- **[🧹 Chores]** Delete dockitens ([520adb5](https://github.com/Ronnasayd/dotfiles/commit/520adb5))
- **[♻️ Refactoring]** Add symbolic links ([17918f1](https://github.com/Ronnasayd/dotfiles/commit/17918f1))
- **[♻️ Refactoring]** Update ([7daaa97](https://github.com/Ronnasayd/dotfiles/commit/7daaa97))
- **[♻️ Refactoring]** Update ([74002d9](https://github.com/Ronnasayd/dotfiles/commit/74002d9))
- **[♻️ Refactoring]** Adjust names ([1e024cc](https://github.com/Ronnasayd/dotfiles/commit/1e024cc))

### **2024-11-19**

- **[🧹 Chores]** Add more aliases ([1832fe5](https://github.com/Ronnasayd/dotfiles/commit/1832fe5))
- **[🧹 Chores]** Update keybindings ([5960131](https://github.com/Ronnasayd/dotfiles/commit/5960131))

### **2024-11-18**

- **[🧹 Chores]** Add comments to aliases ([519013e](https://github.com/Ronnasayd/dotfiles/commit/519013e))

### **2024-11-14**

- **[✨ Features]** Add camera icon ([b441f77](https://github.com/Ronnasayd/dotfiles/commit/b441f77))
- **[♻️ Refactoring]** Update alias ([f4b95a5](https://github.com/Ronnasayd/dotfiles/commit/f4b95a5))
- **[♻️ Refactoring]** Add alias ([0e95e12](https://github.com/Ronnasayd/dotfiles/commit/0e95e12))
- **[🧹 Chores]** Refactor crontab and backup .gs file ([9ca2b65](https://github.com/Ronnasayd/dotfiles/commit/9ca2b65))

### **2024-11-13**

- **[🧹 Chores]** Remove file ([afd3f58](https://github.com/Ronnasayd/dotfiles/commit/afd3f58))
- **[🚧 Other Changes]** Update icons ([0e654eb](https://github.com/Ronnasayd/dotfiles/commit/0e654eb))
- **[✨ Features]** Set icon theme ([0b8e027](https://github.com/Ronnasayd/dotfiles/commit/0b8e027))
- **[✨ Features]** Add my theme ([6e272bd](https://github.com/Ronnasayd/dotfiles/commit/6e272bd))
- **[♻️ Refactoring]** Add emoji conventional commits and rename files ([c3c14ae](https://github.com/Ronnasayd/dotfiles/commit/c3c14ae))
- **[🧹 Chores]** Add new icons ([2b8d6e2](https://github.com/Ronnasayd/dotfiles/commit/2b8d6e2))
- **[🐛 Bug Fixes]** Adjusting missing terms ([6905196](https://github.com/Ronnasayd/dotfiles/commit/6905196))

### **2024-11-12**

- **[📚 Documentation]** Update message ([02bd141](https://github.com/Ronnasayd/dotfiles/commit/02bd141))
- **[🐛 Bug Fixes]** Adjusting regex ([545c571](https://github.com/Ronnasayd/dotfiles/commit/545c571))

### **2024-11-11**

- **[♻️ Refactoring]** Update ([63d075e](https://github.com/Ronnasayd/dotfiles/commit/63d075e))

### **2024-11-08**

- **[♻️ Refactoring]** Update ([d33c88f](https://github.com/Ronnasayd/dotfiles/commit/d33c88f))
- **[♻️ Refactoring]** Update ([85d31dd](https://github.com/Ronnasayd/dotfiles/commit/85d31dd))
- **[♻️ Refactoring]** Update ([f01b8b7](https://github.com/Ronnasayd/dotfiles/commit/f01b8b7))
- **[♻️ Refactoring]** Update ([6dd3ffe](https://github.com/Ronnasayd/dotfiles/commit/6dd3ffe))
- **[♻️ Refactoring]** Update ([04c46b3](https://github.com/Ronnasayd/dotfiles/commit/04c46b3))

### **2024-11-07**

- **[♻️ Refactoring]** Update ([3eb1e2d](https://github.com/Ronnasayd/dotfiles/commit/3eb1e2d))
- **[♻️ Refactoring]** Update ([a734a6c](https://github.com/Ronnasayd/dotfiles/commit/a734a6c))
- **[🧹 Chores]** Update ([42e6bbd](https://github.com/Ronnasayd/dotfiles/commit/42e6bbd))
- **[♻️ Refactoring]** Update ([7825d90](https://github.com/Ronnasayd/dotfiles/commit/7825d90))

### **2024-11-06**

- **[♻️ Refactoring]** Update ([7d29269](https://github.com/Ronnasayd/dotfiles/commit/7d29269))

### **2024-11-05**

- **[♻️ Refactoring]** Update ([8b9a844](https://github.com/Ronnasayd/dotfiles/commit/8b9a844))
- **[♻️ Refactoring]** Update ([05f03a7](https://github.com/Ronnasayd/dotfiles/commit/05f03a7))
- **[♻️ Refactoring]** Update ([776c6c3](https://github.com/Ronnasayd/dotfiles/commit/776c6c3))

### **2024-11-04**

- **[♻️ Refactoring]** Update ([768d5ab](https://github.com/Ronnasayd/dotfiles/commit/768d5ab))
- **[♻️ Refactoring]** Update ([1378a23](https://github.com/Ronnasayd/dotfiles/commit/1378a23))
- **[♻️ Refactoring]** Update ([f24524f](https://github.com/Ronnasayd/dotfiles/commit/f24524f))

### **2024-11-03**

- **[♻️ Refactoring]** Update ([2e0040f](https://github.com/Ronnasayd/dotfiles/commit/2e0040f))

### **2024-11-01**

- **[♻️ Refactoring]** Update ([0b42d60](https://github.com/Ronnasayd/dotfiles/commit/0b42d60))
- **[♻️ Refactoring]** Update ([d427820](https://github.com/Ronnasayd/dotfiles/commit/d427820))

### **2024-10-30**

- **[♻️ Refactoring]** Update ([70da504](https://github.com/Ronnasayd/dotfiles/commit/70da504))

### **2024-10-29**

- **[♻️ Refactoring]** Update ([655e211](https://github.com/Ronnasayd/dotfiles/commit/655e211))
- **[♻️ Refactoring]** Adjusts ([c2c7b83](https://github.com/Ronnasayd/dotfiles/commit/c2c7b83))
- **[♻️ Refactoring]** Adjusts ([3617b6b](https://github.com/Ronnasayd/dotfiles/commit/3617b6b))

### **2024-10-28**

- **[♻️ Refactoring]** Adjusts ([1ebdec2](https://github.com/Ronnasayd/dotfiles/commit/1ebdec2))
- **[♻️ Refactoring]** Create script folder ([1e47cce](https://github.com/Ronnasayd/dotfiles/commit/1e47cce))
- **[♻️ Refactoring]** Adjusts ([1c8b91c](https://github.com/Ronnasayd/dotfiles/commit/1c8b91c))

### **2024-10-25**

- **[♻️ Refactoring]** Update ([68093e2](https://github.com/Ronnasayd/dotfiles/commit/68093e2))
- **[♻️ Refactoring]** Adjusts ([aef9db9](https://github.com/Ronnasayd/dotfiles/commit/aef9db9))

### **2024-10-24**

- **[♻️ Refactoring]** Update ([c25a5f1](https://github.com/Ronnasayd/dotfiles/commit/c25a5f1))
- **[♻️ Refactoring]** Update ([40da919](https://github.com/Ronnasayd/dotfiles/commit/40da919))

### **2024-10-23**

- **[♻️ Refactoring]** Update ([7314de1](https://github.com/Ronnasayd/dotfiles/commit/7314de1))

### **2024-10-22**

- **[♻️ Refactoring]** Update ([65e72b8](https://github.com/Ronnasayd/dotfiles/commit/65e72b8))
- **[♻️ Refactoring]** Update ([60e2ca5](https://github.com/Ronnasayd/dotfiles/commit/60e2ca5))
- **[♻️ Refactoring]** Update ([ec1578c](https://github.com/Ronnasayd/dotfiles/commit/ec1578c))
- **[♻️ Refactoring]** Update ([84d6150](https://github.com/Ronnasayd/dotfiles/commit/84d6150))

### **2024-10-01**

- **[♻️ Refactoring]** Update ([aa8baff](https://github.com/Ronnasayd/dotfiles/commit/aa8baff))

### **2024-09-24**

- **[♻️ Refactoring]** Update ([c8c1dfe](https://github.com/Ronnasayd/dotfiles/commit/c8c1dfe))
- **[♻️ Refactoring]** Update ([9a0a3b7](https://github.com/Ronnasayd/dotfiles/commit/9a0a3b7))

### **2024-09-23**

- **[♻️ Refactoring]** Update ([04e643b](https://github.com/Ronnasayd/dotfiles/commit/04e643b))

### **2024-09-20**

- **[♻️ Refactoring]** Update ([f70be66](https://github.com/Ronnasayd/dotfiles/commit/f70be66))

### **2024-09-12**

- **[♻️ Refactoring]** Update ([4d55b14](https://github.com/Ronnasayd/dotfiles/commit/4d55b14))

### **2024-09-06**

- **[♻️ Refactoring]** Update ([1e2e991](https://github.com/Ronnasayd/dotfiles/commit/1e2e991))

### **2024-09-04**

- **[♻️ Refactoring]** Update ([efb376b](https://github.com/Ronnasayd/dotfiles/commit/efb376b))

### **2024-08-29**

- **[♻️ Refactoring]** Update ([eb18eda](https://github.com/Ronnasayd/dotfiles/commit/eb18eda))
- **[♻️ Refactoring]** Update ([353668d](https://github.com/Ronnasayd/dotfiles/commit/353668d))
- **[♻️ Refactoring]** Update ([ac67e86](https://github.com/Ronnasayd/dotfiles/commit/ac67e86))
- **[♻️ Refactoring]** Update ([f8a9fee](https://github.com/Ronnasayd/dotfiles/commit/f8a9fee))
- **[♻️ Refactoring]** Update ([4a920bc](https://github.com/Ronnasayd/dotfiles/commit/4a920bc))

### **2024-08-28**

- **[♻️ Refactoring]** Update ([1c7ff19](https://github.com/Ronnasayd/dotfiles/commit/1c7ff19))
- **[♻️ Refactoring]** Update ([b8b343b](https://github.com/Ronnasayd/dotfiles/commit/b8b343b))
- **[♻️ Refactoring]** Update ([35df3c7](https://github.com/Ronnasayd/dotfiles/commit/35df3c7))

### **2024-08-27**

- **[♻️ Refactoring]** Update ([07e31d4](https://github.com/Ronnasayd/dotfiles/commit/07e31d4))
- **[♻️ Refactoring]** Update ([c0ed118](https://github.com/Ronnasayd/dotfiles/commit/c0ed118))

### **2024-08-24**

- **[♻️ Refactoring]** Update ([0a7e0e4](https://github.com/Ronnasayd/dotfiles/commit/0a7e0e4))

### **2024-08-23**

- **[♻️ Refactoring]** Update ([54f6af8](https://github.com/Ronnasayd/dotfiles/commit/54f6af8))
- **[♻️ Refactoring]** Update ([136ca3e](https://github.com/Ronnasayd/dotfiles/commit/136ca3e))
- **[♻️ Refactoring]** Update ([c0f65fe](https://github.com/Ronnasayd/dotfiles/commit/c0f65fe))
- **[♻️ Refactoring]** Update ([01fd0e8](https://github.com/Ronnasayd/dotfiles/commit/01fd0e8))

### **2024-08-22**

- **[♻️ Refactoring]** Update ([2d94cec](https://github.com/Ronnasayd/dotfiles/commit/2d94cec))
- **[♻️ Refactoring]** Update ([527756e](https://github.com/Ronnasayd/dotfiles/commit/527756e))

### **2024-08-11**

- **[♻️ Refactoring]** Update ([deb759a](https://github.com/Ronnasayd/dotfiles/commit/deb759a))
- **[♻️ Refactoring]** Update ([432accb](https://github.com/Ronnasayd/dotfiles/commit/432accb))

### **2024-08-03**

- **[♻️ Refactoring]** Update ([e8dfc95](https://github.com/Ronnasayd/dotfiles/commit/e8dfc95))

### **2024-08-01**

- **[♻️ Refactoring]** Update ([77af110](https://github.com/Ronnasayd/dotfiles/commit/77af110))

### **2024-07-31**

- **[♻️ Refactoring]** Update ([9d692da](https://github.com/Ronnasayd/dotfiles/commit/9d692da))
- **[♻️ Refactoring]** Update ([cd4d328](https://github.com/Ronnasayd/dotfiles/commit/cd4d328))
- **[♻️ Refactoring]** Update ([3567179](https://github.com/Ronnasayd/dotfiles/commit/3567179))
- **[♻️ Refactoring]** Update ([6499eb2](https://github.com/Ronnasayd/dotfiles/commit/6499eb2))
- **[♻️ Refactoring]** Update ([7d8d164](https://github.com/Ronnasayd/dotfiles/commit/7d8d164))

### **2024-07-22**

- **[♻️ Refactoring]** Update ([ad24295](https://github.com/Ronnasayd/dotfiles/commit/ad24295))

### **2024-07-16**

- **[♻️ Refactoring]** Remove cpu_status ([89c5254](https://github.com/Ronnasayd/dotfiles/commit/89c5254))

### **2024-07-15**

- **[♻️ Refactoring]** Update ([dac4c62](https://github.com/Ronnasayd/dotfiles/commit/dac4c62))

### **2024-07-04**

- **[♻️ Refactoring]** Update ([ac19c16](https://github.com/Ronnasayd/dotfiles/commit/ac19c16))
- **[♻️ Refactoring]** Update ([5cbc068](https://github.com/Ronnasayd/dotfiles/commit/5cbc068))

### **2024-07-03**

- **[♻️ Refactoring]** Update ([b3891a3](https://github.com/Ronnasayd/dotfiles/commit/b3891a3))
- **[♻️ Refactoring]** Update ([993b4fd](https://github.com/Ronnasayd/dotfiles/commit/993b4fd))
- **[♻️ Refactoring]** Update ([ddafb5d](https://github.com/Ronnasayd/dotfiles/commit/ddafb5d))
- **[♻️ Refactoring]** Update ([ad26a13](https://github.com/Ronnasayd/dotfiles/commit/ad26a13))

### **2024-07-02**

- **[♻️ Refactoring]** Update ([71976ff](https://github.com/Ronnasayd/dotfiles/commit/71976ff))
- **[♻️ Refactoring]** Update ([1f7d5ae](https://github.com/Ronnasayd/dotfiles/commit/1f7d5ae))
- **[♻️ Refactoring]** Update ([62766f2](https://github.com/Ronnasayd/dotfiles/commit/62766f2))

### **2024-07-01**

- **[♻️ Refactoring]** Update ([7d40018](https://github.com/Ronnasayd/dotfiles/commit/7d40018))

### **2024-06-21**

- **[♻️ Refactoring]** Adjusts ([86dd709](https://github.com/Ronnasayd/dotfiles/commit/86dd709))
- **[♻️ Refactoring]** Adjusts ([0459da3](https://github.com/Ronnasayd/dotfiles/commit/0459da3))

### **2024-05-27**

- **[✨ Features]** Update ([aebdc1c](https://github.com/Ronnasayd/dotfiles/commit/aebdc1c))

### **2024-05-08**

- **[♻️ Refactoring]** Update ([1fc7785](https://github.com/Ronnasayd/dotfiles/commit/1fc7785))

### **2024-05-03**

- **[♻️ Refactoring]** Update dotfiles ([588a231](https://github.com/Ronnasayd/dotfiles/commit/588a231))
- **[♻️ Refactoring]** Update dotfiles ([1117389](https://github.com/Ronnasayd/dotfiles/commit/1117389))

### **2024-02-08**

- **[♻️ Refactoring]** Add new zshrc ([b64a73d](https://github.com/Ronnasayd/dotfiles/commit/b64a73d))

### **2024-02-06**

- **[♻️ Refactoring]** Refactor conda ([e2f3560](https://github.com/Ronnasayd/dotfiles/commit/e2f3560))
- **[♻️ Refactoring]** Refactor conda ([3be92cf](https://github.com/Ronnasayd/dotfiles/commit/3be92cf))

### **2024-01-11**

- **[♻️ Refactoring]** Updates ([e51d9a4](https://github.com/Ronnasayd/dotfiles/commit/e51d9a4))
- **[♻️ Refactoring]** Updates ([8e7e913](https://github.com/Ronnasayd/dotfiles/commit/8e7e913))
- **[♻️ Refactoring]** Updates ([44673bb](https://github.com/Ronnasayd/dotfiles/commit/44673bb))

### **2024-01-10**

- **[♻️ Refactoring]** Updates ([b00d312](https://github.com/Ronnasayd/dotfiles/commit/b00d312))
- **[♻️ Refactoring]** Updates ([50a37de](https://github.com/Ronnasayd/dotfiles/commit/50a37de))
- **[♻️ Refactoring]** Updates ([095a578](https://github.com/Ronnasayd/dotfiles/commit/095a578))
- **[♻️ Refactoring]** Updates ([738fea2](https://github.com/Ronnasayd/dotfiles/commit/738fea2))

### **2024-01-09**

- **[♻️ Refactoring]** Updates ([ded32f7](https://github.com/Ronnasayd/dotfiles/commit/ded32f7))
- **[♻️ Refactoring]** Updates ([21d4e3a](https://github.com/Ronnasayd/dotfiles/commit/21d4e3a))
- **[♻️ Refactoring]** Updates ([1ea55a5](https://github.com/Ronnasayd/dotfiles/commit/1ea55a5))
- **[♻️ Refactoring]** Updates ([ea95f9b](https://github.com/Ronnasayd/dotfiles/commit/ea95f9b))
- **[♻️ Refactoring]** Updates ([15a6432](https://github.com/Ronnasayd/dotfiles/commit/15a6432))
- **[♻️ Refactoring]** Updates ([66c6baa](https://github.com/Ronnasayd/dotfiles/commit/66c6baa))

### **2024-01-08**

- **[♻️ Refactoring]** Updates ([b58e573](https://github.com/Ronnasayd/dotfiles/commit/b58e573))
- **[♻️ Refactoring]** Updates ([05bf2fd](https://github.com/Ronnasayd/dotfiles/commit/05bf2fd))

### **2024-01-06**

- **[♻️ Refactoring]** Updates ([0cf097a](https://github.com/Ronnasayd/dotfiles/commit/0cf097a))
- **[♻️ Refactoring]** Updates ([4c37ba9](https://github.com/Ronnasayd/dotfiles/commit/4c37ba9))
- **[♻️ Refactoring]** Updates ([d5fac27](https://github.com/Ronnasayd/dotfiles/commit/d5fac27))
- **[♻️ Refactoring]** Updates ([25411a2](https://github.com/Ronnasayd/dotfiles/commit/25411a2))

### **2024-01-05**

- **[♻️ Refactoring]** Updates ([ae16694](https://github.com/Ronnasayd/dotfiles/commit/ae16694))
- **[♻️ Refactoring]** Updates ([e7baf3a](https://github.com/Ronnasayd/dotfiles/commit/e7baf3a))
- **[♻️ Refactoring]** Updates ([6f43563](https://github.com/Ronnasayd/dotfiles/commit/6f43563))
- **[♻️ Refactoring]** Updates ([a363400](https://github.com/Ronnasayd/dotfiles/commit/a363400))

### **2024-01-04**

- **[♻️ Refactoring]** Updates ([ff6208b](https://github.com/Ronnasayd/dotfiles/commit/ff6208b))
- **[♻️ Refactoring]** Updates ([e670e59](https://github.com/Ronnasayd/dotfiles/commit/e670e59))
- **[♻️ Refactoring]** Updates ([6b05ba1](https://github.com/Ronnasayd/dotfiles/commit/6b05ba1))
- **[♻️ Refactoring]** Updates ([c133ba2](https://github.com/Ronnasayd/dotfiles/commit/c133ba2))

### **2024-01-03**

- **[♻️ Refactoring]** Updates ([7aeb032](https://github.com/Ronnasayd/dotfiles/commit/7aeb032))
- **[♻️ Refactoring]** Updates ([336d6d9](https://github.com/Ronnasayd/dotfiles/commit/336d6d9))
- **[♻️ Refactoring]** Updates ([8ac3a2b](https://github.com/Ronnasayd/dotfiles/commit/8ac3a2b))
- **[♻️ Refactoring]** Updates ([4aabbb7](https://github.com/Ronnasayd/dotfiles/commit/4aabbb7))
- **[🚧 Other Changes]** B2772b6 - updates | 2024-01-03
- **[🚧 Other Changes]** 9f94fbb - updates | 2024-01-03

### **2024-01-02**

- **[🚧 Other Changes]** 93b555d - updates | 2024-01-02

### **2023-12-31**

- **[🚧 Other Changes]** A6695fe - updates | 2023-12-31
- **[🚧 Other Changes]** Ba0a84b - updates | 2023-12-31

### **2023-12-27**

- **[🚧 Other Changes]** F8f7514 - updates | 2023-12-27
- **[🚧 Other Changes]** 7048f2f - updates | 2023-12-27
- **[🚧 Other Changes]** 216c907 - updates | 2023-12-27

### **2023-12-26**

- **[🚧 Other Changes]** 8d579a6 - updates | 2023-12-26

### **2023-12-22**

- **[🚧 Other Changes]** Bddc02d - updates | 2023-12-22

### **2023-12-21**

- **[🚧 Other Changes]** Ce2be4a - updates | 2023-12-21

### **2023-12-20**

- **[🚧 Other Changes]** 4bc0a91 - updates | 2023-12-20
- **[🚧 Other Changes]** 1b8c27d - updates | 2023-12-20
- **[🚧 Other Changes]** 51b011e - updates | 2023-12-20
- **[🚧 Other Changes]** Ee87184 - updates | 2023-12-20

### **2023-12-19**

- **[🚧 Other Changes]** 5bc1aea - updates | 2023-12-19

### **2023-12-15**

- **[🚧 Other Changes]** 8902ec8 - updates | 2023-12-15

### **2023-12-14**

- **[🚧 Other Changes]** 1f18cd8 - updates | 2023-12-14
- **[🚧 Other Changes]** 15ea899 - updates | 2023-12-14
- **[🚧 Other Changes]** D6a6def - update theme | 2023-12-14
- **[🚧 Other Changes]** 48ccabf - update theme | 2023-12-14
- **[🚧 Other Changes]** 2d834dc - updates | 2023-12-14

### **2023-12-12**

- **[🚧 Other Changes]** 2a7f79e - updates | 2023-12-12
- **[🚧 Other Changes]** Ad0251f - updates | 2023-12-12

### **2023-12-11**

- **[♻️ Refactoring]** Updates ([c31e49b](https://github.com/Ronnasayd/dotfiles/commit/c31e49b))
- **[♻️ Refactoring]** Updates ([07e2d67](https://github.com/Ronnasayd/dotfiles/commit/07e2d67))
- **[♻️ Refactoring]** Updates ([a09416d](https://github.com/Ronnasayd/dotfiles/commit/a09416d))

### **2023-12-10**

- **[♻️ Refactoring]** Updates ([ab743c5](https://github.com/Ronnasayd/dotfiles/commit/ab743c5))
- **[♻️ Refactoring]** Updates ([264da10](https://github.com/Ronnasayd/dotfiles/commit/264da10))

### **2023-12-09**

- **[♻️ Refactoring]** Updates ([334dbf3](https://github.com/Ronnasayd/dotfiles/commit/334dbf3))
- **[♻️ Refactoring]** Remove whitespaces ([f0c1051](https://github.com/Ronnasayd/dotfiles/commit/f0c1051))
- **[♻️ Refactoring]** Remove whitespaces ([b003743](https://github.com/Ronnasayd/dotfiles/commit/b003743))
- **[♻️ Refactoring]** Remove unused files ([e6191ca](https://github.com/Ronnasayd/dotfiles/commit/e6191ca))
- **[♻️ Refactoring]** Update ([8b54816](https://github.com/Ronnasayd/dotfiles/commit/8b54816))
- **[♻️ Refactoring]** Update ([5f5f185](https://github.com/Ronnasayd/dotfiles/commit/5f5f185))
- **[♻️ Refactoring]** Update ([1f5fcdc](https://github.com/Ronnasayd/dotfiles/commit/1f5fcdc))
- **[♻️ Refactoring]** Update ([6ddd4d5](https://github.com/Ronnasayd/dotfiles/commit/6ddd4d5))
- **[♻️ Refactoring]** Update ([ced2986](https://github.com/Ronnasayd/dotfiles/commit/ced2986))
- **[♻️ Refactoring]** Update ([0b75ac5](https://github.com/Ronnasayd/dotfiles/commit/0b75ac5))
- **[♻️ Refactoring]** Update ([c42d717](https://github.com/Ronnasayd/dotfiles/commit/c42d717))
- **[♻️ Refactoring]** Update ([b4de488](https://github.com/Ronnasayd/dotfiles/commit/b4de488))
- **[♻️ Refactoring]** Update ([eb53210](https://github.com/Ronnasayd/dotfiles/commit/eb53210))
- **[♻️ Refactoring]** Update ([86e0d9d](https://github.com/Ronnasayd/dotfiles/commit/86e0d9d))
- **[♻️ Refactoring]** Update ([84866bd](https://github.com/Ronnasayd/dotfiles/commit/84866bd))
- **[♻️ Refactoring]** Update ([7ec8ad2](https://github.com/Ronnasayd/dotfiles/commit/7ec8ad2))
- **[♻️ Refactoring]** Update ([f9478f3](https://github.com/Ronnasayd/dotfiles/commit/f9478f3))
- **[♻️ Refactoring]** Add more dotfiles ([88a0b51](https://github.com/Ronnasayd/dotfiles/commit/88a0b51))

### **2023-12-07**

- **[♻️ Refactoring]** Update ([fec0ec5](https://github.com/Ronnasayd/dotfiles/commit/fec0ec5))

### **2023-12-06**

- **[♻️ Refactoring]** Adjust vue problem ([f8a1903](https://github.com/Ronnasayd/dotfiles/commit/f8a1903))
- **[♻️ Refactoring]** Adjust vue problem ([eafe7b9](https://github.com/Ronnasayd/dotfiles/commit/eafe7b9))

### **2023-12-05**

- **[♻️ Refactoring]** Add new zshrc ([02dd82f](https://github.com/Ronnasayd/dotfiles/commit/02dd82f))
- **[♻️ Refactoring]** Add new zshrc ([c824847](https://github.com/Ronnasayd/dotfiles/commit/c824847))
- **[♻️ Refactoring]** Add new zshrc ([d429fb5](https://github.com/Ronnasayd/dotfiles/commit/d429fb5))

### **2023-12-04**

- **[♻️ Refactoring]** Add new zshrc ([50c7001](https://github.com/Ronnasayd/dotfiles/commit/50c7001))
- **[♻️ Refactoring]** Add new zshrc ([ebba229](https://github.com/Ronnasayd/dotfiles/commit/ebba229))

### **2023-12-02**

- **[♻️ Refactoring]** Add new zshrc ([baa75cf](https://github.com/Ronnasayd/dotfiles/commit/baa75cf))
- **[♻️ Refactoring]** Add new zshrc ([4f8324c](https://github.com/Ronnasayd/dotfiles/commit/4f8324c))

### **2023-11-30**

- **[♻️ Refactoring]** Add ga ([ace0695](https://github.com/Ronnasayd/dotfiles/commit/ace0695))

### **2023-11-29**

- **[♻️ Refactoring]** Adjusts at zsh ([14090e2](https://github.com/Ronnasayd/dotfiles/commit/14090e2))
- **[♻️ Refactoring]** Adjusts at zsh ([161e760](https://github.com/Ronnasayd/dotfiles/commit/161e760))

### **2023-11-27**

- **[♻️ Refactoring]** Add plugins ([9068ac2](https://github.com/Ronnasayd/dotfiles/commit/9068ac2))

### **2023-10-23**

- **[♻️ Refactoring]** Add alias ([40b533c](https://github.com/Ronnasayd/dotfiles/commit/40b533c))

### **2023-07-26**

- **[♻️ Refactoring]** Adjusts ([d1de070](https://github.com/Ronnasayd/dotfiles/commit/d1de070))

### **2023-07-22**

- **[♻️ Refactoring]** Adjusts at vim ([353565a](https://github.com/Ronnasayd/dotfiles/commit/353565a))

### **2023-07-20**

- **[♻️ Refactoring]** Adjusts ([eea5212](https://github.com/Ronnasayd/dotfiles/commit/eea5212))

### **2023-07-12**

- **[♻️ Refactoring]** Adjusts ([6bb5a27](https://github.com/Ronnasayd/dotfiles/commit/6bb5a27))
- **[♻️ Refactoring]** Adjusts ([e1ccac1](https://github.com/Ronnasayd/dotfiles/commit/e1ccac1))

### **2023-07-10**

- **[♻️ Refactoring]** Adjusts ([15c8e9d](https://github.com/Ronnasayd/dotfiles/commit/15c8e9d))

### **2023-07-07**

- **[♻️ Refactoring]** Adjusts ([2955c5d](https://github.com/Ronnasayd/dotfiles/commit/2955c5d))

### **2022-05-18**

- **[♻️ Refactoring]** Update dotfiles ([537ef70](https://github.com/Ronnasayd/dotfiles/commit/537ef70))
- **[♻️ Refactoring]** Update dotfiles ([7de0e9f](https://github.com/Ronnasayd/dotfiles/commit/7de0e9f))
- **[♻️ Refactoring]** Update dotfiles ([4909114](https://github.com/Ronnasayd/dotfiles/commit/4909114))
- **[♻️ Refactoring]** Update dotfiles ([36ca020](https://github.com/Ronnasayd/dotfiles/commit/36ca020))
- **[♻️ Refactoring]** Update dotfiles ([d2e2e7b](https://github.com/Ronnasayd/dotfiles/commit/d2e2e7b))
- **[♻️ Refactoring]** Update dotfiles ([52c168a](https://github.com/Ronnasayd/dotfiles/commit/52c168a))
- **[♻️ Refactoring]** Update dotfiles ([df79ed3](https://github.com/Ronnasayd/dotfiles/commit/df79ed3))
- **[♻️ Refactoring]** Update dotfiles ([9692f92](https://github.com/Ronnasayd/dotfiles/commit/9692f92))
- **[♻️ Refactoring]** Update dotfiles ([bda9f8c](https://github.com/Ronnasayd/dotfiles/commit/bda9f8c))

### **2022-05-17**

- **[♻️ Refactoring]** Update dotfiles ([71bb994](https://github.com/Ronnasayd/dotfiles/commit/71bb994))
- **[♻️ Refactoring]** Update dotfiles ([147a924](https://github.com/Ronnasayd/dotfiles/commit/147a924))
- **[♻️ Refactoring]** Update dotfiles ([18403e6](https://github.com/Ronnasayd/dotfiles/commit/18403e6))
- **[♻️ Refactoring]** Update dotfiles ([d59cfb4](https://github.com/Ronnasayd/dotfiles/commit/d59cfb4))
- **[♻️ Refactoring]** Update dotfiles ([f23e146](https://github.com/Ronnasayd/dotfiles/commit/f23e146))
- **[♻️ Refactoring]** Update dotfiles ([44743d2](https://github.com/Ronnasayd/dotfiles/commit/44743d2))

### **2022-05-16**

- **[♻️ Refactoring]** Update dotfiles ([3a7cc00](https://github.com/Ronnasayd/dotfiles/commit/3a7cc00))
- **[♻️ Refactoring]** Update dotfiles ([ada994f](https://github.com/Ronnasayd/dotfiles/commit/ada994f))
- **[♻️ Refactoring]** Update dotfiles ([5b1e2f7](https://github.com/Ronnasayd/dotfiles/commit/5b1e2f7))
- **[♻️ Refactoring]** Update dotfiles ([eacea84](https://github.com/Ronnasayd/dotfiles/commit/eacea84))
- **[♻️ Refactoring]** Update dotfiles ([e357705](https://github.com/Ronnasayd/dotfiles/commit/e357705))

### **2022-05-15**

- **[♻️ Refactoring]** Update dotfiles ([d623cd8](https://github.com/Ronnasayd/dotfiles/commit/d623cd8))
- **[♻️ Refactoring]** Update dotfiles ([5b3f9ad](https://github.com/Ronnasayd/dotfiles/commit/5b3f9ad))

### **2021-09-09**

- **[♻️ Refactoring]** Add mode plugins ([195c2d0](https://github.com/Ronnasayd/dotfiles/commit/195c2d0))

### **2021-03-28**

- **[♻️ Refactoring]** Update vimrc ([746a678](https://github.com/Ronnasayd/dotfiles/commit/746a678))

### **2021-02-19**

- **[📚 Documentation]** Vscode ([21ef2da](https://github.com/Ronnasayd/dotfiles/commit/21ef2da))

### **2021-02-18**

- **[📚 Documentation]** Update vscode ([3bf2bc1](https://github.com/Ronnasayd/dotfiles/commit/3bf2bc1))

### **2020-11-16**

- **[✨ Features]** Add vetur in vscode for vue projects ([28cdf91](https://github.com/Ronnasayd/dotfiles/commit/28cdf91))

### **2020-10-27**

- **[📚 Documentation]** Add jsconfig ([e213060](https://github.com/Ronnasayd/dotfiles/commit/e213060))

### **2020-10-14**

- **[📚 Documentation]** Update vscode ([c62cc1e](https://github.com/Ronnasayd/dotfiles/commit/c62cc1e))
- **[📚 Documentation]** New files ([a73ee67](https://github.com/Ronnasayd/dotfiles/commit/a73ee67))

### **2020-09-22**

- **[🧹 Chores]** Bump standard-version from 7.1.0 to 8.0.1 ([3b05784](https://github.com/Ronnasayd/dotfiles/commit/3b05784))
- **[🧹 Chores]** Add devmoji ([27f6638](https://github.com/Ronnasayd/dotfiles/commit/27f6638))

### **2020-07-24**

- **[📚 Documentation]** Update vscode ([84ed609](https://github.com/Ronnasayd/dotfiles/commit/84ed609))

### **2020-07-15**

- **[📚 Documentation]** Add aliases and settings ([cbabfb3](https://github.com/Ronnasayd/dotfiles/commit/cbabfb3))

### **2020-07-03**

- **[📚 Documentation]** Add vimrc ([aa978cd](https://github.com/Ronnasayd/dotfiles/commit/aa978cd))
- **[📚 Documentation]** Add vimrc ([4c57e5e](https://github.com/Ronnasayd/dotfiles/commit/4c57e5e))
- **[📚 Documentation]** Add vimrc ([60e588f](https://github.com/Ronnasayd/dotfiles/commit/60e588f))

### **2020-07-02**

- **[📚 Documentation]** Add vimrc ([c553ae7](https://github.com/Ronnasayd/dotfiles/commit/c553ae7))
- **[📚 Documentation]** Add vimrc ([f4326ef](https://github.com/Ronnasayd/dotfiles/commit/f4326ef))
- **[📚 Documentation]** Add vimrc zshrc ([c49cad7](https://github.com/Ronnasayd/dotfiles/commit/c49cad7))
- **[📚 Documentation]** Add vimrc ([f5a91e4](https://github.com/Ronnasayd/dotfiles/commit/f5a91e4))
- **[📚 Documentation]** Vimrc ([d3e0cc1](https://github.com/Ronnasayd/dotfiles/commit/d3e0cc1))
- **[📚 Documentation]** Add zshrc ([c84ec3b](https://github.com/Ronnasayd/dotfiles/commit/c84ec3b))
- **[📚 Documentation]** Add vimrc ([ee21f5a](https://github.com/Ronnasayd/dotfiles/commit/ee21f5a))

### **2020-07-01**

- **[📚 Documentation]** Add vimrc ([b19bb2a](https://github.com/Ronnasayd/dotfiles/commit/b19bb2a))
- **[📚 Documentation]** Add zshrc ([83177e7](https://github.com/Ronnasayd/dotfiles/commit/83177e7))
- **[📚 Documentation]** Add zshrc ([61274d6](https://github.com/Ronnasayd/dotfiles/commit/61274d6))
- **[📚 Documentation]** Add zshrc ([240719b](https://github.com/Ronnasayd/dotfiles/commit/240719b))
- **[📚 Documentation]** Add vimrc and zshrc ([0a1e061](https://github.com/Ronnasayd/dotfiles/commit/0a1e061))

### **2020-06-30**

- **[📚 Documentation]** Add vimrc and zshrc ([a17de80](https://github.com/Ronnasayd/dotfiles/commit/a17de80))
- **[📚 Documentation]** Update vim ([59b8db2](https://github.com/Ronnasayd/dotfiles/commit/59b8db2))
- **[📚 Documentation]** Update vim ([5911706](https://github.com/Ronnasayd/dotfiles/commit/5911706))

### **2020-06-25**

- **[📚 Documentation]** Add editorconfig vim ([bcb5f3a](https://github.com/Ronnasayd/dotfiles/commit/bcb5f3a))
- **[📚 Documentation]** Update .vimrc ([8a7b16f](https://github.com/Ronnasayd/dotfiles/commit/8a7b16f))

### **2020-06-24**

- **[📚 Documentation]** Add python intelisense ([55cbe2f](https://github.com/Ronnasayd/dotfiles/commit/55cbe2f))
- **[📚 Documentation]** Update vimrc ([945ac6d](https://github.com/Ronnasayd/dotfiles/commit/945ac6d))
- **[📚 Documentation]** Update vimrc ([c87249b](https://github.com/Ronnasayd/dotfiles/commit/c87249b))
- **[📚 Documentation]** Update vimrc ([6afd7db](https://github.com/Ronnasayd/dotfiles/commit/6afd7db))

### **2020-06-22**

- **[📚 Documentation]** Add nerdcommenter ([72f85c8](https://github.com/Ronnasayd/dotfiles/commit/72f85c8))

### **2020-06-21**

- **[📚 Documentation]** Add vimrc ([3489e11](https://github.com/Ronnasayd/dotfiles/commit/3489e11))
- **[📚 Documentation]** Ajust cursor zsh ([6023b54](https://github.com/Ronnasayd/dotfiles/commit/6023b54))
- **[📚 Documentation]** Add themes to terminator (dracula) ([781c0b4](https://github.com/Ronnasayd/dotfiles/commit/781c0b4))
- **[📚 Documentation]** Add ./vimrc ([4f02e84](https://github.com/Ronnasayd/dotfiles/commit/4f02e84))
- **[📚 Documentation]** Add vim-plug ([674f42a](https://github.com/Ronnasayd/dotfiles/commit/674f42a))

### **2020-06-20**

- **[📚 Documentation]** Add vim as default editor ([be24c73](https://github.com/Ronnasayd/dotfiles/commit/be24c73))

### **2020-06-02**

- **[📚 Documentation]** Add powerlevel9k ([e3e42bb](https://github.com/Ronnasayd/dotfiles/commit/e3e42bb))

### **2020-05-31**

- **[🧹 Chores]** Add commitizen init ([87981c6](https://github.com/Ronnasayd/dotfiles/commit/87981c6))

### **2020-05-25**

- **[📚 Documentation]** Add intellicode ([9589d8a](https://github.com/Ronnasayd/dotfiles/commit/9589d8a))

### **2020-03-31**

- **[📚 Documentation]** Add more extensions ([aa8c12e](https://github.com/Ronnasayd/dotfiles/commit/aa8c12e))

### **2020-03-22**

- **[♻️ Refactoring]** Adicionando configuraçoes vscode e lista de extensoes ([d89c49d](https://github.com/Ronnasayd/dotfiles/commit/d89c49d))

---
Generated on 2026-03-12 17:17:02