function vsc
    if test (count $argv) -eq 0
        code .  # Se nenhum argumento for fornecido, abre o diretório atual
    else
        code $argv  # Caso contrário, abre o arquivo/diretório fornecido
    end
end
