#!/usr/bin/env python3
import os
import sys


def is_binary_file(file_path, blocksize=512):
    """
    Verifica se o arquivo é binário ou texto.

    Args:
        file_path (str): Caminho do arquivo.
        blocksize (int): Quantidade de bytes para ler e inspecionar (padrão 512).

    Returns:
        bool: True se arquivo for binário, False se for texto.
    """
    text_characters = bytearray(
        {7, 8, 9, 10, 12, 13, 27} | set(range(0x20, 0x100)) - {0x7F}
    )
    with open(file_path, "rb") as file:
        block = file.read(blocksize)
        if not block:
            # Arquivo vazio pode ser considerado texto
            return False
        nontext = block.translate(None, text_characters)
        # Se mais que 30% dos caracteres não são texto, é binário
        return float(len(nontext)) / len(block) > 0.3


def main():
    args = sys.argv
    to_exclude = [
        "node_modules/",
        ".env",
        ".git/",
        "venv/",
        ".png",
        ".jpeg",
        ".token",
        "__init__.py",
    ]
    all_files = []
    context = ""
    for item in args[1:]:
        for root, _, files in os.walk(item):
            for file in files:
                filepath = os.path.join(root, file)
                # verificar se nenhum termo de exclusão está no caminho
                if not any(excluded in filepath for excluded in to_exclude):
                    all_files.append(filepath)
    for file in all_files:
        if not is_binary_file(file):
            context += f"// filepath: {file}\n"
            with open(file, "r", encoding="utf-8") as f:
                context += f.read() + "\n\n"
    print(context)


if __name__ == "__main__":
    main()
