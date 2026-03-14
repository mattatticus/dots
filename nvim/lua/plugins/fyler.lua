local M        = {
    "A7Lavinraj/fyler.nvim",
    branch = "stable",
    lazy = false,
}

M.opts         = {}

M.dependencies = { "nvim-mini/mini.icons" }

M.keys         = {
    {
        mode = { "n" },
        "<leader>o",
        function()
            require "fyler".toggle { kind = "split_right_most" }
        end
    },
}

return M
