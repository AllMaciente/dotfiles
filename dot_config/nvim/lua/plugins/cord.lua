return {
  {
    'vyfor/cord.nvim',
    event = "VeryLazy",
    build = function()
      -- Try to update cord, but don't fail if it doesn't work
      local ok, _ = pcall(vim.cmd, "Cord update")
      if not ok then
        vim.notify("cord.nvim: Build failed, continuing anyway...", vim.log.WARN)
      end
    end,
    opts = {}
  }
}
