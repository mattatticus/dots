vim.pack.add {
    "https://github.com/nvim-mini/mini.pick",
    "https://github.com/folke/which-key.nvim"
}

require "which-key".setup()

require "mini.pick".setup()

vim.keymap.set(
    { "n" },
    "<leader>o",
    function()
        MiniPick.builtin.files()
    end,
    {
        silent = true,
        noremap = true,
        desc = "Jump to previous diagnostic",
    }
)
