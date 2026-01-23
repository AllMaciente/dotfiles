-- lua/plugins/lsp.lua
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    local lspconfig = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Lista de servidores a serem instalados pelo Mason
    local servers = {
      -- Frontend
      'html',
      'cssls',
      'tsserver',
      'tailwindcss',
      -- Outros servidores que você usa
      'lua_ls',
      'bashls',
    }

    -- Configuração do Mason
    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = servers,
    })

    -- Configurações padrão para todos os LSPs
    local default_setup = function(server_name)
      lspconfig[server_name].setup({
        capabilities = capabilities,
      })
    end

    -- Loop para configurar todos os servidores com as configurações padrão
    require('mason-lspconfig').setup_handlers({
      default_setup,
      -- Configurações específicas por servidor, se necessário
      ['tailwindcss'] = function()
        lspconfig.tailwindcss.setup({
          capabilities = capabilities,
          -- Isso garante que o tailwindcss-language-server seja ativado para esses filetypes
          filetypes = { 'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'css', 'svelte', 'vue' },
          -- Inicia o LSP apenas se encontrar um tailwind.config.js no projeto
          root_dir = lspconfig.util.root_pattern('tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.mjs'),
        })
      end,
      ['tsserver'] = function()
        lspconfig.tsserver.setup({
            capabilities = capabilities,
            -- Garante que o tsserver atenda a todos os formatos de JS/TS
            filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
        })
      end,
    })

    -- Keymaps do LSP (coloque os que você já usa)
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      end,
    })
  end,
}