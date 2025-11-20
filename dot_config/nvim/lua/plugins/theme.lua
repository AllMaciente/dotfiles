return {
  {
    "AlphaTechnolog/pywal.nvim",
    lazy = false, -- Importante: Garante que carregue no início
    config = function()
      local pywal = require("pywal")
      
      pywal.setup()
      vim.cmd("colorscheme pywal")

      -- --- MÁGICA DO LIVE RELOAD ---
      -- Cria um "ouvinte" para o sinal SIGUSR1
      vim.api.nvim_create_autocmd("Signal", {
        pattern = "SIGUSR1",
        callback = function()
          vim.schedule(function()
            -- 1. Recarrega as cores
            vim.cmd("colorscheme pywal")
            
            -- 2. Se você usa Lualine, força a atualização dele também
            if package.loaded['lualine'] then
               require('lualine').refresh()
            end
            
            print("Cores do Pywal atualizadas!")
          end)
        end,
      })
    end,
  },
}
