# Argument completion for custom function aliases (see .alias.zshrc / .functions.zshrc)

# Branch-name completion for git branch aliases
compdef _git_branch_names gdbr git-diff-branch
compdef _git_branch_names ogdb open-git-diff-branch

# Commit-hash completion
_git_commit_hashes() {
  local -a hashes
  hashes=(${(f)"$(git log --format='%h:%s' 2>/dev/null)"})
  _describe 'commit' hashes
}
compdef _git_commit_hashes gdfc git_diff_code

# docker-compose file completion (*.yml/*.yaml)
_compose_files() {
  _files -g '*.(yml|yaml)'
}
compdef _compose_files dcb docker-compose-build
compdef _compose_files dcu docker-compose-up
compdef _compose_files dcd docker-compose-down

# generic file/path completion
compdef _files mf make-file
compdef _files v2f video2frames
compdef _files f2v frames2video
compdef _files cv cut-video
compdef _files gfps get-fps
compdef _files lv loop-video
compdef _files cf copyfile

# directory completion
compdef _files -/ ft find-text
compdef _files -/ cwe copy-with-exclusion
