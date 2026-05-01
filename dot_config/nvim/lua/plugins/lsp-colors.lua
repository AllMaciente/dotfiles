-- lua/plugins/lsp-colors.lua
return {
    "folke/lsp-colors.nvim",
    event = "LspAttach",
    config = function()
        require("lsp-colors").setup({
            Error = "#db4b4b",
            Warning = "#e0af68",
            Info = "#0db9d7",
            Hint = "#10B981",
        })
    end
}
