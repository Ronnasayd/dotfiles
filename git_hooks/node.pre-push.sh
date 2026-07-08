#!/bin/sh

get_main_branch() {
  local branch
  branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
  if [ -z "$branch" ]; then
    git remote set-head origin -a >/dev/null 2>&1
    branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
  fi
  echo "${branch:-main}"
}

MAIN_BRANCH=$(get_main_branch)

# Valida nome da branch antes do push
allowed_pattern='^(feature|feat|fix|chore|docs|refactor|perf|test|style)/[A-Za-z0-9][A-Za-z0-9._-]*$'
protected_pattern='^(main|master|homolog)$'

validate_branch() {
  name="$1"
  if printf '%s\n' "$name" | grep -Eq "$allowed_pattern"; then
    return 0
  fi
  return 1
}

invalid=0
while read -r local_ref local_sha remote_ref remote_sha; do
  case "$local_ref" in
    refs/heads/*)
      branch="${local_ref#refs/heads/}"
      if printf '%s\n' "$branch" | grep -Eq "$protected_pattern"; then
        echo "Push direto em branch protegida nao permitido: $branch" >&2
        invalid=1
        continue
      fi
      if ! validate_branch "$branch"; then
        echo "Nome de branch invalido: $branch" >&2
        echo "Formato esperado: <tipo>/<descricao> (ex: feat/add-login)" >&2
        echo "Tipos permitidos: feature, feat, fix, chore, docs, refactor, perf, test, style" >&2
        invalid=1
      fi
      ;;
  esac
done

if [ "$invalid" -ne 0 ]; then
  exit 1
fi

# Executa os testes
yarn test --changedSince=$MAIN_BRANCH

# Verifica o código de saída dos testes
if [ $? -ne 0 ]; then
  echo "Os testes falharam. O push foi abortado." >&2
  exit 1 # Sai com erro para abortar o push
fi

exit 0 # Sai com sucesso para permitir o push
