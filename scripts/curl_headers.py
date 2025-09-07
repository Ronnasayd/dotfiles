#!/usr/bin/env python3
import shlex
import sys

import pyperclip

"""
Script: curl_headers.py
Uso: python curl_headers.py
Lê o comando curl do clipboard, extrai apenas os headers que seriam enviados (-H/--header, User-Agent, etc) e salva em headers.txt no diretório atual. NÃO executa o comando curl.
"""


def main():
    # Lê o comando do clipboard
    cmd_input = pyperclip.paste().strip()
    if not cmd_input.startswith("curl"):
        print("O comando no clipboard deve começar com 'curl'.")
        sys.exit(1)

    # Parse argumentos do curl
    args = shlex.split(cmd_input)
    curl_args = args[1:]

    headers = []
    user_agent = None

    i = 0
    while i < len(curl_args):
        arg = curl_args[i]
        if arg in ("-H", "--header") and i + 1 < len(curl_args):
            headers.append(curl_args[i + 1])
            i += 2
        elif arg in ("-A", "--user-agent") and i + 1 < len(curl_args):
            user_agent = curl_args[i + 1]
            i += 2
        else:
            i += 1

    # Adiciona User-Agent se presente
    if user_agent:
        headers.append(f"User-Agent: {user_agent}")

    # Se não houver headers, avisa
    if not headers:
        print("Nenhum header encontrado no comando curl.")

    # Escreve headers.txt no diretório atual
    with open("headers.txt", "w", encoding="utf-8") as f:
        for h in headers:
            f.write(h.strip() + "\n")
    print("Arquivo headers.txt criado com sucesso.")


if __name__ == "__main__":
    main()
