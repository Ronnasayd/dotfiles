#!/usr/bin/python3
import argparse
import fnmatch
import os
from concurrent.futures import ThreadPoolExecutor, as_completed

from dotenv import load_dotenv

home_directory = os.path.expanduser("~")

load_dotenv(dotenv_path=home_directory + "/.secrets/gcia.env")

DEFAULT_EXCLUDE = [
    "node_modules/",
    "vendor/" ".env",
    ".git/",
    "venv/",
    ".png",
    ".jpeg",
    ".token",
    ".svg",
    ".pytest_cache",
    ".vscode-test",
    ".nuxt/",
    "dist/",
    "build/",
    "__init__.py",
]

DEFAULT_CONTENT_EXCLUDE = os.getenv("DEFAULT_CONTENT_EXCLUDE").split(",")


def is_binary_file(file_path, blocksize=512):
    try:
        with open(file_path, "rb") as f:
            block = f.read(blocksize)
        if not block:
            return False
        if b"\0" in block:
            return True
        text_chars = bytearray(range(32, 127)) + b"\n\r\t\b"
        non_text = [byte for byte in block if byte not in text_chars]
        return len(non_text) / len(block) > 0.3
    except Exception:
        return True


def should_exclude(file_path, exclude_patterns):
    for pattern in exclude_patterns:
        if fnmatch.fnmatch(file_path, f"*{pattern}*"):
            return True
    return False


def read_file(file, must_list, content_exclude):
    try:
        if not is_binary_file(file):
            filepath = file.replace(home_directory, "~")
            if must_list:
                return f"// filepath: {filepath}\n"
            with open(file, "r", encoding="utf-8") as f:
                content = f.read()
                # Mascarar conteúdo com base nos padrões
                for pattern in content_exclude:
                    content = re.sub(
                        re.escape(pattern),
                        "[PRIVATE-INFO]",
                        content,
                        flags=re.IGNORECASE,
                    )
            return f"// filepath: {filepath}\n{content}\n"

        else:
            return None
    except Exception as e:
        filepath = file.replace(home_directory, "~")
        return f"// ERRO ao ler arquivo {filepath}: {e}\n"


def main():
    parser = argparse.ArgumentParser(description="Indexa arquivos texto paralelamente")
    parser.add_argument("paths", nargs="+", help="Diretórios ou arquivos para indexar")
    parser.add_argument(
        "--exclude",
        nargs="*",
        default=[*DEFAULT_EXCLUDE],
        help="Padrões para arquivos/pastas a excluir",
    )
    parser.add_argument(
        "--content_exclude",
        nargs="*",
        default=[*DEFAULT_CONTENT_EXCLUDE],
        help="Padrões para conteúdos a mascarar com [PRIVATE-INFO]",
    )
    parser.add_argument(
        "--workers",
        type=int,
        default=8,
        help="Número de threads simultâneas (padrão: 8)",
    )
    parser.add_argument(
        "--list",
        type=bool,
        default=False,
        help="Apenas listar arquivos",
    )
    args = parser.parse_args()
    args.exclude = sorted(set(DEFAULT_EXCLUDE + (args.exclude or [])))
    args.content_exclude = sorted(
        set(DEFAULT_CONTENT_EXCLUDE + (args.content_exclude or [])),
        key=lambda x: len(x),
        reverse=True,
    )

    all_files = []
    for item in args.paths:
        if os.path.isfile(item):
            all_files.append(item)
        else:
            for root, _, files in os.walk(item):
                for file in files:
                    filepath = os.path.join(root, file)
                    if not should_exclude(filepath, args.exclude):
                        all_files.append(filepath)

    # Multithreading na leitura dos arquivos
    results = []
    with ThreadPoolExecutor(max_workers=args.workers) as executor:
        future_to_file = {
            executor.submit(read_file, file, args.list, args.content_exclude): file
            for file in all_files
        }
        for future in as_completed(future_to_file):
            result = future.result()
            if result:
                results.append(result)

    print("\n".join(results))


if __name__ == "__main__":
    main()
