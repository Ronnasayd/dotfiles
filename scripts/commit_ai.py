#!/usr/bin/env python3
import os
import subprocess
import sys

import requests
from dotenv import load_dotenv


home_directory = os.path.expanduser("~")
load_dotenv(dotenv_path=os.path.join(home_directory, ".secrets", "openrouter.env"))

# 1. Obter diff dos arquivos staged
diff = subprocess.run(
    ["git", "diff", "--cached"], capture_output=True, text=True
).stdout

if not diff.strip():
    print("⚠️  Nenhuma alteração staged encontrada.")
    sys.exit(1)

# 2. Obter chave da API
api_key = os.getenv("OPENROUTER_API_KEY")
if not api_key:
    print("❌ Variável de ambiente OPENROUTER_API_KEY não encontrada.")
    sys.exit(1)

# 3. Chamar API do OpenRouter
url = "https://openrouter.ai/api/v1/chat/completions"
payload = {
    "model": "openai/gpt-oss-20b:free",  # Pode trocar para outro modelo disponível
    "messages": [
        {
            "role": "system",
            "content": "Você é um assistente que escreve mensagens de commit curtas, no formato conventional commits.",
        },
        {
            "role": "user",
            "content": f"Analise as alterações abaixo e crie uma mensagem de commit clara e concisa:\n\n{diff}",
        },
    ],
    "temperature": 0.3,
}

headers = {"Authorization": f"Bearer {api_key}", "Content-Type": "application/json"}

try:
    response = requests.post(url, json=payload, headers=headers)
    response.raise_for_status()
    commit_message = response.json()["choices"][0]["message"]["content"].strip()

    # 4. Executar commit
    subprocess.run(["git", "commit", "-m", commit_message])
    print(f"✅ Commit criado: {commit_message}")

except requests.RequestException as e:
    print(f"❌ Erro na requisição: {e}")
    sys.exit(1)
