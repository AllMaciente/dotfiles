-- lua/plugins/emmet.lua
return {
  'mattn/emmet-vim',
  init = function()
    -- Configuração para o Emmet reconhecer e expandir corretamente em JSX/TSX
    vim.g.user_emmet_settings = {
      html = {
        -- Define um perfil padrão para HTML que será estendido por JS/TS
        ['profile'] = {
          ['tag_nl'] = true,       -- Insere nova linha após tag de abertura
          ['tag_indent'] = true,   -- Indenta o conteúdo da tag
          ['attribute_quotes'] = 'single', -- Mantém as aspas simples nos atributos
        },
      },
      javascript = {
        extends = 'html', -- Estende o perfil HTML
        ['syntax'] = 'jsx',
        -- Força o uso de className em vez de class para JSX
        ['attr_quotes'] = 'single', -- Garante aspas simples para JS
      },
      typescript = {
        extends = 'html', -- Estende o perfil HTML
        ['syntax'] = 'tsx',
        ['attr_quotes'] = 'single', -- Garante aspas simples para TS
      },
      javascriptreact = {
        extends = 'javascript', -- Estende o perfil JS
      },
      typescriptreact = {
        extends = 'typescript', -- Estende o perfil TS
      },
    }
  end
}
