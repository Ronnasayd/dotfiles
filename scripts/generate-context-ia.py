#!/usr/bin/python3
import argparse
import fnmatch
import hashlib
import os
import re  # Usar re padrão do Python
from concurrent.futures import ThreadPoolExecutor, as_completed

from dotenv import load_dotenv

home_directory = os.path.expanduser("~")
load_dotenv(dotenv_path=os.path.join(home_directory, ".secrets", "gcia.env"))

DEFAULT_EXCLUDE = [
    "/node_modules/",
    "/vendor/",
    ".env",
    "/.git/",
    "venv/",
    ".png",
    ".jpeg",
    ".token.json",
    ".svg",
    ".pytest_cache",
    ".vscode-test",
    "/.nuxt/",
    "/dist/",
    "/build/",
    "__init__.py",
    "/.pytest_cache/",
]

DEFAULT_CONTENT_EXCLUDE = os.getenv("DEFAULT_CONTENT_EXCLUDE", "").split(",")


def short_hash(texto, tamanho=8):
    hash_completo = hashlib.sha256(texto.encode()).hexdigest()
    return hash_completo[:tamanho]


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


def should_exclude(file_path, exclude_dirs, exclude_files, include_dirs):
    # Extrai diretórios do caminho para ver se deve incluir/excluir

    # Excluir se for arquivo e bater com padrão de arquivo a excluir
    for pattern in exclude_files:
        if fnmatch.fnmatch(file_path, f"*{pattern}"):
            return True

    # Se o caminho bate com include dirs, força a inclusão
    for pattern in include_dirs:
        if fnmatch.fnmatch(file_path, f"*{pattern}*"):
            return False  # inclui

    # Excluir se o caminho bater com algum diretório a excluir
    for pattern in exclude_dirs:
        if fnmatch.fnmatch(file_path, f"*{pattern}*"):
            return True  # exclui

    return False


def read_file(file, must_list, content_exclude):
    filepath = file.replace(home_directory, "~")
    try:
        if is_binary_file(file):
            return None

        filepath = private_values_dir(content_exclude, filepath)
        if must_list:
            return f"// filepath: {filepath}"

        try:
            with open(file, "r", encoding="utf-8") as f:
                content = f.read()
        except UnicodeDecodeError:
            with open(file, "r", encoding="latin-1") as f:
                content = f.read()

        content = re.sub(r"^\s*\n", "", content, flags=re.MULTILINE)
        content = private_values(content_exclude, content, value="[PRIVATE-INFO]")

        return f"// filepath: {filepath}\n{content}\n"

    except Exception as e:
        return f"// ERRO ao ler arquivo {filepath}: {e}\n"


def private_values(content_exclude, content, value):
    for pattern in content_exclude:
        pattern = pattern.strip()
        if pattern:
            content = re.sub(re.escape(pattern), value, content, flags=re.IGNORECASE)

    return content


def private_values_dir(content_exclude, content):
    for pattern in content_exclude:
        pattern = pattern.strip()
        if pattern:
            content = re.sub(
                re.escape(pattern), short_hash(pattern), content, flags=re.IGNORECASE
            )

    return content


def parse_exclude_list(value):
    return [item.strip() for item in value.split(",") if item.strip()]


def split_exclude_patterns(patterns):
    exclude_dirs = []
    exclude_files = []
    for p in patterns:
        p = p.strip()
        if p.endswith("/") or os.path.isdir(p):
            exclude_dirs.append(p)
        else:
            exclude_files.append(p)
    return exclude_dirs, exclude_files


def main():
    parser = argparse.ArgumentParser(description="Indexa arquivos texto paralelamente")
    parser.add_argument("paths", nargs="+", help="Diretórios ou arquivos para indexar")
    parser.add_argument(
        "--exclude",
        type=parse_exclude_list,
        default=[],
        help="Lista de padrões a excluir, separados por vírgula (ex: node_modules/,venv/,dist/)",
    )
    parser.add_argument(
        "--exclude-content",
        type=parse_exclude_list,
        default=[],
        help="Padrões para conteúdos a mascarar com [PRIVATE-INFO] (ex: node_modules/,venv/,dist/)",
    )
    parser.add_argument(
        "--workers",
        type=int,
        default=8,
        help="Número de threads simultâneas (padrão: 8)",
    )
    parser.add_argument(
        "--list",
        action="store_true",
        help="Apenas listar arquivos",
    )
    parser.add_argument(
        "--include",
        type=parse_exclude_list,
        default=[],
        help="Lista de padrões a incluir, separados por vírgula (ex: src/,tests/)",
    )

    args = parser.parse_args()
    combined_exclude = sorted(set(DEFAULT_EXCLUDE + (args.exclude or [])))

    exclude_dirs, exclude_files = split_exclude_patterns(combined_exclude)
    include_dirs = sorted(set(args.include or []))

    args.exclude_content = sorted(
        set(DEFAULT_CONTENT_EXCLUDE + (args.exclude_content or [])),
        key=len,
        reverse=True,
    )

    all_files = []
    for item in args.paths:
        if os.path.isfile(item):
            if not should_exclude(item, exclude_dirs, exclude_files, include_dirs):
                all_files.append(item)
        else:
            for root, _, files in os.walk(item):
                for file in files:
                    filepath = os.path.join(root, file)
                    if not should_exclude(
                        filepath, exclude_dirs, exclude_files, include_dirs
                    ):
                        all_files.append(filepath)

    results = []
    with ThreadPoolExecutor(max_workers=args.workers) as executor:
        futures = {
            executor.submit(read_file, file, args.list, args.exclude_content): file
            for file in all_files
        }
        for future in as_completed(futures):
            result = future.result()
            if result:
                results.append(result)

    print("\n".join(results))


if __name__ == "__main__":
    main()
