local M = {
    "nvim-lualine/lualine.nvim",
    lazy = false,
}

M.dependencies = { "catppuccin/nvim" }

local colors = require "catppuccin.palettes".get_palette("mocha")

local theme = {
    normal = {
        a = { fg = colors.crust, bg = colors.blue },
        b = { fg = colors.surface1, bg = colors.crust },
        c = { fg = colors.surface1, bg = colors.mantle },
        z = { fg = colors.crust, bg = colors.blue },
    },
    insert = {
        a = { fg = colors.crust, bg = colors.green }
    },
    visual = {
        a = { fg = colors.crust, bg = colors.peach }
    },
    replace = {
        a = { fg = colors.crust, bg = colors.green }
    },
}


M.opts = function()
    local empty = require("lualine.component"):extend()
    function empty:draw(default_highlight)
        self.status = ""
        self.applied_separator = ""
        self:apply_highlights(default_highlight)
        self:apply_section_separators()
        return self.status
    end

    -- Put proper separators and gaps between components in sections
    local function process_sections(sections)
        for name, section in pairs(sections) do
            local left = name:sub(9, 10) < "x"
            for pos = 1, name ~= "lualine_z" and #section or #section - 1 do
                table.insert(section, pos * 2, { empty, color = { fg = colors.mantle, bg = colors.mantle } })
            end
            for id, comp in ipairs(section) do
                if type(comp) ~= "table" then
                    comp = { comp }
                    section[id] = comp
                end
                comp.separator = left and { right = "" } or { left = "" }
            end
        end
        return sections
    end

    local function header()
        return "󰹻"
    end

    local function modified()
        if vim.bo.modified then
            return '󱦹 '
        end

        return ""
    end

    local function readonly()
        if vim.bo.modifiable == false or vim.bo.readonly == true then
            return '󰌾 '
        end

        return ""
    end

    return {

        options = {
            theme = theme,
            component_separators = "",
            section_separators = { left = "", right = "" },
        },
        sections = process_sections {
            lualine_a = { header },
            lualine_b = {
                "%l:%c",
                { modified, color = { bg = colors.green, fg = colors.mantle } },
                { readonly, color = { bg = colors.peach, fg = colors.mantle } }
            },
            lualine_c = {},
            lualine_x = {
                {
                    'diagnostics',
                    source = { 'nvim' },
                    sections = { 'hint' },
                    symbols = { hint = ' ' },
                    diagnostics_color = { hint = { bg = colors.teal, fg = colors.mantle } },
                },
                {
                    'diagnostics',
                    source = { 'nvim' },
                    sections = { 'info' },
                    symbols = { info = ' ' },
                    diagnostics_color = { info = { bg = colors.sapphire, fg = colors.mantle } },
                },
                {
                    'diagnostics',
                    source = { 'nvim' },
                    sections = { 'warn' },
                    symbols = { warn = ' ' },
                    diagnostics_color = { warn = { bg = colors.yellow, fg = colors.mantle } },
                },
                {
                    'diagnostics',
                    source = { 'nvim' },
                    sections = { 'error' },
                    symbols = { error = '󰈸 ' },
                    diagnostics_color = { error = { bg = colors.red, fg = colors.mantle } },
                },
            },
            lualine_y = {
                {
                    "lsp_status",
                    icon = "󰒋",
                    show_name = false,
                    color = { bg = colors.peach, fg = colors.mantle },
                    symbols = {
                        spinner = {
                            "󰫃",
                            "󰫄",
                            "󰫅",
                            "󰫆",
                            "󰫇",
                            "󰫈",
                        },
                    }
                },
                { "filename", file_status = false, path = 0 },
            },
            lualine_z = { "mode" },
        },
    }
end

return M
