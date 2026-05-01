return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").compilers = { "clang", "gcc" }
      vim.cmd("TSUpdateSync")
    end,
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "lua",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}

