-- lua/plugins/autotag.lua
return {
  'windwp/nvim-ts-autotag',
  config = function()
    require('nvim-ts-autotag').setup({
      opts = {
        -- Ativa para os filetypes desejados
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
      -- Adicione aqui os filetypes que você quer que o plugin atue
      filetypes = { 'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx' },
    })
  end,
}
