# Scripts

Executar qualquer script deste diretório direto do GitHub, sem clonar o repo.

Base da URL raw:

```
https://raw.githubusercontent.com/Ronnasayd/dotfiles/master/scripts/<nome-do-script>
```

## Python, sem args (stdlib só)

```bash
curl -sL https://raw.githubusercontent.com/Ronnasayd/dotfiles/master/scripts/<nome>.py | python3 -
```

Via `uv` (resolve python/deps automaticamente, inclusive deps declaradas via
PEP 723 no topo do script):

```bash
uv run https://raw.githubusercontent.com/Ronnasayd/dotfiles/master/scripts/<nome>.py
```

## Shell (bash), sem args

```bash
curl -sL https://raw.githubusercontent.com/Ronnasayd/dotfiles/master/scripts/<nome>.sh | bash
```

## Python ou shell, com args

Pipe não passa `sys.argv`/`$@` de forma confiável. Baixe pra um arquivo
temporário antes de rodar:

```bash
curl -sL -o /tmp/script.py https://raw.githubusercontent.com/Ronnasayd/dotfiles/master/scripts/<nome>.py
python3 /tmp/script.py [args]
```

```bash
curl -sL -o /tmp/script.sh https://raw.githubusercontent.com/Ronnasayd/dotfiles/master/scripts/<nome>.sh
bash /tmp/script.sh [args]
```

Ou shell via pipe com `bash -s --` (funciona p/ scripts sem precisar deps
instaladas antes):

```bash
curl -sL https://raw.githubusercontent.com/Ronnasayd/dotfiles/master/scripts/<nome>.sh | bash -s -- [args]
```

## Exemplo concreto: build-changelog.py (Python)

Gera `CHANGELOG.md` a partir do histórico git do repositório atual (precisa
estar dentro de um repo git).

```bash
curl -sL https://raw.githubusercontent.com/Ronnasayd/dotfiles/master/scripts/build-changelog.py | python3 -
```

## Exemplo concreto: cleanup-system.sh (bash, com args)

Libera espaço em disco (cache docker, apt, journald, etc). Aceita `--dry-run`
e `--aggressive`.

```bash
curl -sL https://raw.githubusercontent.com/Ronnasayd/dotfiles/master/scripts/cleanup-system.sh | bash -s -- --dry-run
```

> Scripts baixados da rede são dado não confiável. Revise o conteúdo antes de
> rodar sem clonar — principalmente coisa destrutiva (rm, dd, etc). Scripts
> que dependem de outros arquivos do repo (não só stdlib/paths externos) não
> funcionam isolados dessa forma — precisam do clone.

## Catálogo

| Script                      | O que faz                                                                                                 | Args     |
| --------------------------- | --------------------------------------------------------------------------------------------------------- | -------- |
| `backgroundslide.sh`        | Troca wallpaper aleatório a cada 15s em loop (Cinnamon/MATE).                                             | Não      |
| `build-changelog.py`        | Gera `CHANGELOG.md` a partir do histórico git (tags/commits convencionais).                               | Não      |
| `build-system.sh`           | Instala pacotes base, asdf e Docker num sistema novo.                                                     | Não      |
| `change_background_auto.sh` | Troca wallpaper via conky, sincronizado com cache de stats.                                               | Não      |
| `change_background.sh`      | Mata instâncias duplicadas do troca-wallpaper e relança (watchdog).                                       | Não      |
| `clean-chrome-config.sh`    | Limpa cache do Chrome preservando cookies/logins/extensões.                                               | Não      |
| `cleanup-system.sh`         | Libera espaço em disco (docker, apt, journald, snap, kernels velhos); suporta `--dry-run`/`--aggressive`. | Opcional |
| `clean-vscode.sh`           | Limpa caches do VS Code preservando settings/extensões/login.                                             | Não      |
| `colorize-logs.sh`          | Colore saída de logs por padrão de texto.                                                                 | Opcional |
| `commit_ai.py`              | Gera mensagem de commit via IA a partir do diff staged.                                                   | Não      |
| `create_python_wrapper.sh`  | Cria wrapper executável para script Python dentro de venv.                                                | Sim      |
| `create-shortcut.sh`        | Cria atalho de teclado customizado no Cinnamon.                                                           | Sim      |
| `create_swapfile.sh`        | Recria o swapfile do sistema (8GB) e registra no fstab.                                                   | Não      |
| `curl_headers.py`           | Extrai headers de um comando curl do clipboard e salva em `headers.txt`.                                  | Não      |
| `dir_of_symbolic.sh`        | Resolve e imprime o diretório real do script (segue symlink).                                             | Não      |
| `docker.install.sh`         | Instala Docker Engine oficial via apt, removendo pacotes conflitantes.                                    | Não      |
| `find_badblocks.py`         | Roda `badblocks` em paralelo (múltiplas threads) numa partição.                                           | Não      |
| `find_file_badsectors.sh`   | Força leitura de todos arquivos pra RAM (teste de bad sectors via cache).                                 | Não      |
| `firacode-nerdfonts.sh`     | Baixa e instala a fonte FiraCode Nerd Font.                                                               | Não      |
| `generate-qrcode.sh`        | Gera QR code de uma URL (com opção `-w` pra link do WhatsApp).                                            | Sim      |
| `get_gnome_conf.sh`         | Faz backup do dconf (configs GNOME) num arquivo.                                                          | Não      |
| `install-codegen-cli.sh`    | Instala swagger-codegen-cli via wrapper em `/usr/local/bin`.                                              | Não      |
| `jetbrains-mono.sh`         | Baixa e instala a fonte JetBrains Mono Nerd Font.                                                         | Não      |
| `migrate.sh`                | Busca projetos node/python e migra yarn→pnpm e venv→uv.                                                   | Não      |
| `monitor-phone.sh`          | Monitora eventos ACPI do jack de áudio e ajusta perfil/input de áudio.                                    | Não      |
| `opacify_windows.sh`        | Ajusta opacidade de janelas por status/tipo (requer xdotool/wmctrl).                                      | Não      |
| `plex.sh`                   | Recria container Docker do Plex e abre a interface web.                                                   | Não      |
| `proot-termux-build.sh`     | Builda ambiente proot para Termux (requer root).                                                          | Sim      |
| `pscpu.py`                  | Lista processos ordenados por uso de CPU junto com CPU idle do vmstat.                                    | Não      |
| `qr-copy.sh`                | Serve arquivo do clipboard via http+ngrok e gera QR code do link.                                         | Não      |
| `qr-server.sh`              | Serve diretório via http+ngrok e gera QR code do link.                                                    | Opcional |
| `roboto-font.sh`            | Baixa e instala a fonte Roboto do repositório oficial do Google Fonts.                                    | Não      |
| `save.sh`                   | Utilitário para salvar/versionar um arquivo (uso: `save <nome_do_arquivo>`).                              | Sim      |
| `scan_sensitive_content.py` | Varre arquivos/diretório buscando conteúdo sensível (alta entropia/base64 suspeito).                      | Não      |
| `set_icons.sh`              | Define ícones customizados para pastas/atalhos via `gio`.                                                 | Não      |
| `set_trash_icons.sh`        | Substitui ícones de lixeira do tema de ícones atual (com backup).                                         | Não      |
| `vscode-custom-sidebar.js`  | Injeta script no VS Code pra customizar a sidebar via DOM.                                                | Não      |
| `ws.py`                     | Extrai caminhos de workspace recentes do banco sqlite do VS Code.                                         | Não      |
