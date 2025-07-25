function cd --wraps=cd --description "Mudança de diretório com ativação automática do virtualenv ou poetry"
    builtin cd $argv

    # Ativa o .venv local se existir
    if test -d .venv
        source .venv/bin/activate.fish
    else if test -f pyproject.toml
        # Se for um projeto Poetry, ativa o ambiente virtual
        poetry shell
    end
end
