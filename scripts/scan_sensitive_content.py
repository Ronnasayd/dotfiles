import base64
import math
import os
import re


def is_high_entropy_string(s, threshold=4.3):
    """Calcula a entropia de uma string para verificar se é Base64 suspeito"""
    if not s:
        return False
    prob = [float(s.count(c)) / len(s) for c in dict.fromkeys(list(s))]
    entropy = -sum([p * math.log2(p) for p in prob])
    return entropy >= threshold


def is_base64_string(s):
    """Verifica se a string é Base64 válida"""
    try:
        if len(s) % 4 != 0 or len(s) < 20:
            return False
        decoded = base64.b64decode(s, validate=True)
        return is_high_entropy_string(s)
    except Exception:
        return False


def detect_sensitive_content(text):
    """Detecta padrões comuns de chaves e base64"""
    patterns = [
        r"AKIA[0-9A-Z]{16}",  # AWS Access Key ID
        r"ASIA[0-9A-Z]{16}",  # AWS Temporary Access Key
        r"sk_live_[0-9a-zA-Z]{24,}",  # Stripe live secret key
        r"AIza[0-9A-Za-z-_]{35}",  # Google API Key
        r"(?i)-----BEGIN RSA PRIVATE KEY-----.*?-----END RSA PRIVATE KEY-----",  # RSA key
        r"(?i)-----BEGIN PRIVATE KEY-----.*?-----END PRIVATE KEY-----",
        r'(access_token|api_key|secret)[\'"]?\s*[:=]\s*[\'"][a-zA-Z0-9_\-]{20,}[\'"]',
        r"\b[a-fA-F0-9]{32}\b",  # "MD5"
        r"\b[a-fA-F0-9]{40}\b",  # "SHA1"
        r"\b[a-fA-F0-9]{64}\b",  # "SHA256"
        r"\b[a-fA-F0-9]{128}\b",  # "SHA512"
        r"\$2[aby]?\$[0-9]{2}\$[./A-Za-z0-9]{53}",  # "bcrypt"
        r"\b[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\b",  # "UUID"
    ]

    # detect_possible_hashes(text)

    found = []

    # Checar por padrões fixos
    for pattern in patterns:
        matches = re.findall(pattern, text, re.DOTALL)
        if matches:
            found.extend(matches)

    # Checar por strings Base64 de alta entropia
    base64_candidates = re.findall(
        r"[A-Za-z0-9+/=]{20,}",
        text,
    )
    for candidate in base64_candidates:
        if is_base64_string(candidate):
            found.append(f"{candidate}")

    return found


def scan_file(path):
    try:
        with open(path, "r", encoding="utf-8", errors="ignore") as f:
            content = f.read()
            findings = detect_sensitive_content(content)
            if findings:
                print(f"\n[!] Conteúdo suspeito encontrado em: {path}")
                for f in findings:
                    print(f"  → {f}")
                # Ação: bloquear, mover ou deletar o arquivo, se necessário
                # os.remove(path)
                return True
    except Exception as e:
        print(f"[Erro ao ler {path}]: {e}")
    return False


def scan_directory(directory):
    print(f"[>] Escaneando diretório: {directory}")
    for root, _, files in os.walk(directory):
        for file in files:
            full_path = os.path.join(root, file)
            scan_file(full_path)


# Exemplo de uso:
if __name__ == "__main__":
    # Modo 1: Escanear um diretório inteiro
    scan_directory("/home/ronnas/develop/QQ/qq-front/qq-manager")
