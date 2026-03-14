local M = {
    branch = "main",
    "nvim-treesitter/nvim-treesitter",
}

local parsers = {
    "c",
    "go",
    "css",
    -- "cpp",
    "lua",
    "vim",
    "zig",
    "html",
    "fish",
    "rust",
    "glsl",
    "yuck",
    "typst",
    "python",
    "javascript",
}

function M.config()
    local ts = require "nvim-treesitter"
    ts.install(parsers)
end

vim.api.nvim_create_augroup("Treesitter", {})
vim.api.nvim_create_autocmd(
    "FileType",
    {
        pattern = parsers,
        group = "Treesitter",
        callback = function()
            vim.treesitter.start()
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    }
)

return M
