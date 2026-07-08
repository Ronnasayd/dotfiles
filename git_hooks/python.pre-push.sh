#!/bin/sh

# Executa os testes
pytest --disable-warnings --verbose

# Verifica o código de saída dos testes
if [ $? -ne 0 ]; then
  echo "Os testes falharam. O push foi abortado." >&2
  exit 1 # Sai com erro para abortar o push
fi

exit 0 # Sai com sucesso para permitir o push
