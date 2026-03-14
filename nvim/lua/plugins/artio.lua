local M        = {
    "https://codeberg.org/comfysage/artio.nvim",
}

M.dependencies = { "nvim-mini/mini.icons" }

M.opts         = {
    opts = {
        pointer = "", -- pointer for the selected match
        marker = "│", -- prefix for marked items
        bottom = true, -- whether to draw the prompt at the bottom
        shrink = true, -- whether the window should shrink to fit the matches
        preselect = true, -- whether to preselect the first match
        promptprefix = "", -- prefix for the prompt
        prompt_title = true, -- whether to draw the prompt title
        infolist = { "list" }, -- index: [1] list: (4/5)
        use_icons = true, -- requires mini.icons
    },
    win = {
        height = 10,
        hidestatusline = false, -- works best with laststatus=3
    },
    mappings = {
        ["<c-p>"] = "up",
        ["<c-t>"] = "tab",
        ["<c-n>"] = "down",
        ["<tab>"] = "mark",
        ["<cr>"] = "accept",
        ["<c-s>"] = "split",
        ["<esc>"] = "cancel",
        ["<c-v>"] = "vsplit",
        ["<c-g>"] = "togglelive",
        ["<c-l>"] = "togglepreview",
        ["<c-q>"] = "setqflist",
        ["<m-q>"] = "setqflistmark",
    },
}

M.keys         = {
    {
        mode = { "n" },
        "<leader>f",
        function()
            require("artio.builtins").files { findprg = [[ fd -t f -- ]], }
        end
    },

    {
        mode = { "n" },
        "<leader>b",
        function()
            require("artio.builtins").buffers()
        end,
        {
            silent = true,
            noremap = true,
            desc = "Artio diagnostics",
        }
    },

    {
        mode = { "n" },
        "<leader>d",
        function()
            require("artio.builtins").diagnostics()
        end,
        {
            silent = true,
            noremap = true,
            desc = "Artio diagnostics",
        }
    },

    {
        mode = { "n" },
        "<leader>rg",
        function()
            require("artio.builtins").grep()
        end,
        {
            silent = true,
            noremap = true,
            desc = "Artio grep",
        }
    },
}

function M.init()
    vim.ui.select = require("artio").select
end

return M
