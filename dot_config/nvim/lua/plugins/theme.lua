return {
  {
    "AlphaTechnolog/pywal.nvim",
    config = function()
      require("pywal").setup()
      vim.cmd("colorscheme pywal")
    end,
  },
}
