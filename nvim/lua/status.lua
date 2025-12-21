vim.pack.add{
	"https://github.com/nvim-lualine/lualine.nvim"
}

local colors = require"catppuccin.palettes".get_palette("mocha")

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


local empty = require('lualine.component'):extend()
function empty:draw(default_highlight)
	self.status = ''
	self.applied_separator = ''
	self:apply_highlights(default_highlight)
	self:apply_section_separators()
	return self.status
end

-- Put proper separators and gaps between components in sections
local function process_sections(sections)
	for name, section in pairs(sections) do
		local left = name:sub(9, 10) < 'x'
		for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
			table.insert(section, pos * 2, { empty, color = { fg = colors.mantle, bg = colors.mantle } })
		end
		for id, comp in ipairs(section) do
			if type(comp) ~= 'table' then
				comp = { comp }
				section[id] = comp
			end
			comp.separator = left and { right = '' } or { left = '' }
		end
	end
	return sections
end

function header()
	return ""
end

require('lualine').setup {
	options = {
		theme = theme,
		component_separators = '',
		section_separators = { left = '', right = '' },
	},
	sections = process_sections {
		lualine_a = { header },
		lualine_b = { '%l:%c' },
		lualine_c = { },
		lualine_x = {},
		lualine_y = {
			'lsp_status',
			{ 'filename', file_status = false, path = 1 },
		},
		lualine_z = { 'mode' },
	},
}
