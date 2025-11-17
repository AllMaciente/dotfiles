return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "clangd" },
      ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    }
  }
}
