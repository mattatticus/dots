vim.g.command = ""
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set(
    { "" },
    "<Space>",
    "<Nop>",
    {
        silent = true,
        noremap = true,
        desc = "",
    }
)

vim.keymap.set(
    { "t" },
    "<Esc>",
    "<C-\\><C-n>",
    {
        silent = true,
        noremap = true,
        desc = "",
    }
)

vim.keymap.set(
    { "n" },
    "<leader>q",
    function()
        vim.cmd("bd|bp")
    end,
    {
        silent = true,
        noremap = true,
        desc = "Delete and switch buffer",
    }
)
