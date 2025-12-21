local options = {
    autoindent = true,

    clipboard = "unnamedplus",
    complete = "",
    conceallevel = 0,
    cursorline = true,

    expandtab = true,
    fsync = false,

    guifont = "Maple Mono NF:h14",
    linespace = 10,

    hidden = true,

    laststatus = 3,

    mouse = "nv",

    mousescroll = "ver:0,hor:0",

    number = true,
    relativenumber = true,
    ruler = true,

    scrolloff = 8,
    shiftwidth = 4,
    showmode = false,
    sidescrolloff = 10,
    signcolumn = "yes:2",
    smartindent = true,
    smarttab = true,
    splitbelow = true,
    splitright = true,
    swapfile = false,

    tabstop = 4,
    termguicolors = true,

    -- linespace = 8,
    -- lazyredraw = true,
    shadafile = "NONE",
    -- updatecount = 0,
    -- updatetime = 400,

    wrap = false,
    guicursor = "n-v-sm:block,i-c-ci-ve:ver25,r-cr-o:hor20,a:blinkon1-blinkoff1"
}

vim.o.timeout = true
vim.o.timeoutlen = 500

vim.g.command = ""
vim.g.mapleader = " "
vim.g.maplocalleader = " "

for k, v in pairs(options) do
    vim.opt[k] = v
end

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

require "ui"
require "qol"
require "lsp"
require "status"
