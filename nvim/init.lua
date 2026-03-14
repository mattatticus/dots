require "config"

vim.pack.add { "https://github.com/folke/lazy.nvim.git" }

require("lazy").setup {
    defaults = { lazy = true },
    checker = { enabled = true },
    spec = { { import = "plugins" } },
    change_detection = { enabled = false },
    install = { colorscheme = { "catppuccin" } },
}
