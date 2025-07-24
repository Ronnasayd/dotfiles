import os
import sys


def is_binary_file(filepath, blocksize=1024):
    with open(filepath, "rb") as f:
        block = f.read(blocksize)
        # Se o arquivo estiver vazio, consideramos texto (não binário)
        if not block:
            return False
        # Checar se há bytes fora do intervalo ASCII imprimível comum
        # Aqui, apenas um exemplo, ajustável conforme necessidades
        text_chars = bytearray({7, 8, 9, 10, 12, 13, 27} | set(range(0x20, 0x7F)))
        if bool(block.translate(None, text_chars)):
            return True  # Contém bytes incomuns, provável binário
        else:
            return False  # Possivelmente arquivo texto


def main():
    args = sys.argv
    to_exclude = ["node_modules/", ".env", ".git/", "venv/", ".png", ".jpeg", ".token"]
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
