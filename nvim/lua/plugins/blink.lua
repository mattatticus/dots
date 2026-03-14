local M        = {
    version = "1.*",
    "saghen/blink.cmp",
}

M.dependencies = {
    "xzbdmw/colorful-menu.nvim",
    "rafamadriz/friendly-snippets",
}

M.event        = { "BufReadPre", "CmdlineEnter" }

M.opts         = {
    keymap = { preset = 'enter' },
    fuzzy = { implementation = "lua" },
    appearance = { nerd_font_variant = 'mono' },
    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' }, },

    completion = {
        documentation = { auto_show = true },
        menu = {
            draw = {
                -- We don't need label_description now because label and label_description are already
                -- combined together in label by colorful-menu.nvim.
                columns = { { "kind_icon" }, { "label", gap = 1 } },
                components = {
                    label = {
                        width = { fill = true, max = 60 },
                        text = function(ctx)
                            local highlights_info = require("colorful-menu").blink_highlights(ctx)
                            if highlights_info ~= nil then
                                -- Or you want to add more item to label
                                return highlights_info.label
                            else
                                return ctx.label
                            end
                        end,
                        highlight = function(ctx)
                            local highlights = {}
                            local highlights_info = require("colorful-menu").blink_highlights(ctx)
                            if highlights_info ~= nil then
                                highlights = highlights_info.highlights
                            end
                            for _, idx in ipairs(ctx.label_matched_indices) do
                                table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                            end
                            -- Do something else
                            return highlights
                        end,
                    },
                },
            },
        },
    },
}

return M
