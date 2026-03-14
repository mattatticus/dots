local M = {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin"
}

M.opts = {
    flavour = "mocha",
    transparent_background = false,
    float = {
        transparent = false,
        solid = false,
    },
    show_end_of_buffer = false,
    term_colors = true,
    no_italic = false, -- Force no italic
    no_bold = true,
    no_underline = false,
    styles = {
        loops = {},
        strings = {},
        numbers = {},
        booleans = {},
        variables = {},
        operators = {},
        properties = {},
        types = { "italic" },
        keywords = { "italic" },
        comments = { "italic" },
        functions = { "italic" },
        conditionals = { "italic" },
    },
    lsp_styles = {
        virtual_text = {
            ok = { "italic" },
            hints = { "italic" },
            errors = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
        },
        underlines = {
            ok = { "undercurl" },
            hints = { "undercurl" },
            errors = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
        },
        inlay_hints = {
            background = true,
        },
    },
    integrations = {
        artio = true,

        snacks = {
            enabled = true,
            indent_scope_color = "blue", -- catppuccin color (eg. `lavender`) Default: overlay2
        },
    },
    color_overrides = {},
    custom_highlights = {},
    auto_integrations = false,
    default_integrations = true,
}

function M.config(_, opts)
    require "catppuccin".setup(opts)
    require "catppuccin".load()
end

return M
