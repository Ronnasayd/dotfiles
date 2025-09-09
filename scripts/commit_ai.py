#!/usr/bin/env python3
import os
import subprocess
import sys
import requests
from dotenv import load_dotenv

# 🔹 Descobre a raiz do repositório Git (mesmo se script for chamado de outro lugar)
try:
    repo_root = subprocess.run(
        ["git", "rev-parse", "--show-toplevel"],
        capture_output=True, text=True, check=True
    ).stdout.strip()
except subprocess.CalledProcessError:
    print("❌ Este script precisa ser executado dentro de um repositório Git.")
    sys.exit(1)

# 🔹 Carrega variáveis de ambiente do .secrets do usuário
home_directory = os.path.expanduser("~")
load_dotenv(dotenv_path=os.path.join(home_directory, ".secrets", "openrouter.env"))

# 1. Obter diff dos arquivos staged
diff = subprocess.run(
    ["git", "diff", "--cached"], capture_output=True, text=True, cwd=repo_root
).stdout

if not diff.strip():
    print("⚠️  Nenhuma alteração staged encontrada.")
    sys.exit(1)

# 2. Obter chave da API
api_key = os.getenv("OPENROUTER_API_KEY")
if not api_key:
    print("❌ Variável de ambiente OPENROUTER_API_KEY não encontrada.")
    sys.exit(1)

# 3. Chamar API do OpenRouter para gerar mensagem
url = "https://openrouter.ai/api/v1/chat/completions"
payload = {
    "model": "openai/gpt-oss-20b:free",
    "messages": [
        {
            "role": "system",
            "content": "You are an assistant that writes short commit messages in the Conventional Commits format. Thoroughly analyze the changes and create a clear and concise commit message in conventional commit format. Don't start the commit message with any words other than: feat, fix, docs, style, refactor, perf, test, or chore. Don't include any emojis. Ensure the message accurately reflects the changes made.",
        },
        {
            "role": "user",
            "content": f"Analyze the changes below and create a clear and concise commit message:\n\n{diff} in the conventional commits format. Thoroughly analyze the changes and create a clear and concise commit message in conventional commit format. Don't start the commit message with any words other than: feat, fix, docs, style, refactor, perf, test, or chore. Don't include any emojis. Ensure the message accurately reflects the changes made.",
        },
    ],
    "temperature": 0.3,
}

headers = {"Authorization": f"Bearer {api_key}", "Content-Type": "application/json"}

try:
    response = requests.post(url, json=payload, headers=headers)
    response.raise_for_status()
    commit_message = response.json()["choices"][0]["message"]["content"].strip()

    # 4. Executar commit na raiz do repositório certo (garante que o hook commit-msg seja chamado)
    subprocess.run(["git", "commit", "-m", commit_message], cwd=repo_root)
    print(f"✅ Commit criado: {commit_message}")

except requests.RequestException as e:
    print(f"❌ Erro na requisição: {e}")
    sys.exit(1)
