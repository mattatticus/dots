local M        = { "neovim/nvim-lspconfig" }

M.event        = { "BufReadPre" }

M.dependencies = {
    "rachartier/tiny-inline-diagnostic.nvim"
}

M.keys         = {
    {
        mode = { "n" },
        "<leader>h",
        function()
            vim.lsp.buf.format()
        end,
        { desc = "Lsp format buffer" }
    },

    {
        mode = { "n" },
        "<leader>{",
        function()
            vim.diagnostic.jump { count = -1 }
        end,
        { desc = "Jump to previous diagnostic" }
    },

    {
        mode = { "n" },
        "<leader>}",
        function()
            vim.diagnostic.jump { count = 1 }
        end,
        { desc = "Jump to next diagnostic" }
    }
}


local servers = {
    "zls",
    "html",
    "cssls",
    "gopls",
    "denols",
    "clangd",
    "lua_ls",
    "pyright",
    "emmet_ls",
    "tinymist",
    "glsl_analyzer",
    "rust_analyzer",
}

function M.config()
    vim.diagnostic.config {
        underline = true,
        severity_sort = true,
        virtual_text = false,
        update_in_insert = true,
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "󰈸",
                [vim.diagnostic.severity.WARN] = "",
                [vim.diagnostic.severity.HINT] = "",
                [vim.diagnostic.severity.INFO] = "",
            },
        },
    }

    vim.lsp.config(
        "lua_ls", {
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT', -- Specify Lua version
                    },
                    diagnostics = {
                        globals = { 'vim' }, -- Recognize 'vim' as a global variable
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true), -- Include Neovim runtime files
                    },
                    telemetry = {
                        enable = false, -- Disable telemetry
                    },
                },
            }
        }
    )
    vim.lsp.enable(servers)

    vim.api.nvim_create_augroup("AutoFormatting", {})
    vim.api.nvim_create_autocmd(
        "BufWritePre",
        {
            pattern = "*",
            group = "AutoFormatting",
            callback = function()
                local clients = vim.lsp.get_clients {
                    method = "textDocument/formatting",
                    bufnr = vim.api.nvim_get_current_buf(),
                }
                if #clients == 0 then
                    return
                end

                vim.lsp.buf.format { timeout_ms = 250 }
            end,
        }
    )

    -- Tiny inline diagnostic

    require "tiny-inline-diagnostic".setup {
        preset = "ghost",
        options = {
            throttle = 0,
            enable_on_insert = true,
            multiple_diag_under_cursor = true,
            show_all_diags_on_cursorline = true,
        },
    }
end

return M
