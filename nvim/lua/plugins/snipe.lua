local M = { "leath-dub/snipe.nvim" }

M.keys = {
    {
        mode = { "n" },
        "<leader>s",
        function()
            require "snipe".open_buffer_menu()
        end,
        {
            silent = true,
            noremap = true,
            desc = "Snipe menu",
        }
    }
}

function M.opts()
    return {
        ui = {
            preselect = require "snipe".preselect_by_classifier("#"),
            position = "cursor",
            open_win_override = {
                border = "none",
            },
        },
        hints = {
            prefix_key = ".",
            dictionary = "htnsaoeuidgcrl",
        },
    }
end

return M
