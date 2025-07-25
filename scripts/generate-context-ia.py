#!/usr/bin/env python3
import argparse
import fnmatch
import os
from concurrent.futures import ThreadPoolExecutor, as_completed


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


def read_file(file, must_list):
    try:
        if not is_binary_file(file):
            with open(file, "r", encoding="utf-8") as f:
                content = f.read()
            if not must_list:
                return f"// filepath: {file}\n{content}\n"
            return f"// filepath: {file}\n"
        else:
            return None
    except Exception as e:
        return f"// ERRO ao ler arquivo {file}: {e}\n"


def main():
    parser = argparse.ArgumentParser(description="Indexa arquivos texto paralelamente")
    parser.add_argument("paths", nargs="+", help="Diretórios ou arquivos para indexar")
    parser.add_argument(
        "--exclude",
        nargs="*",
        default=[
            "node_modules/",
            ".env",
            ".git/",
            "venv/",
            ".png",
            ".jpeg",
            ".token",
            ".pytest_cache",
            ".vscode-test",
            "__init__.py",
        ],
        help="Padrões para arquivos/pastas a excluir",
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
        help="Apenas listart arquivos",
    )
    args = parser.parse_args()

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
            executor.submit(read_file, file, args.list): file for file in all_files
        }
        for future in as_completed(future_to_file):
            result = future.result()
            if result:
                results.append(result)

    print("\n".join(results))


if __name__ == "__main__":
    main()
