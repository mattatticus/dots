vim.pack.add {
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
}

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

local servers = {
    "zls",
    "clangd",
    "lua_ls",
    "pyright",
    "glsl_analyzer",
}

vim.opt.completeopt = { "menuone", "noinsert", "preview", "fuzzy", "popup" }
vim.opt.wildoptions = { "fuzzy", "pum" }

local function onAttach(client, bufnr)
    local function keymap(lhs, rhs, opts, mode)
        opts = type(opts) == 'string' and { desc = opts }
            or vim.tbl_extend('error', opts --[[@as table]], { buffer = bufnr })
        mode = mode or 'n'
        vim.keymap.set(mode, lhs, rhs, opts)
    end

    local function feedkeys(keys)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'n', true)
    end

    local function pumvisible()
        return tonumber(vim.fn.pumvisible()) ~= 0
    end

    if #vim.lsp.get_clients { method = "textDocument/completion" } == 0 then
        return
    end

    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })

    keymap('<cr>', function()
        return pumvisible() and '<C-y>' or '<cr>'
    end, { expr = true }, 'i')

    keymap('<C-n>', function()
        if pumvisible() then
            feedkeys '<C-n>'
        else
            if next(vim.lsp.get_clients { bufnr = 0 }) then
                vim.lsp.completion.get()
            else
                if vim.bo.omnifunc == '' then
                    feedkeys '<C-x><C-n>'
                else
                    feedkeys '<C-x><C-o>'
                end
            end
        end
    end, 'Trigger/select next completion', 'i')

    keymap('<C-u>', '<C-x><C-n>', { desc = 'Buffer completions' }, 'i')

    keymap('<Tab>', function()
        if pumvisible() then
            feedkeys '<C-n>'
        elseif vim.snippet.active { direction = 1 } then
            vim.snippet.jump(1)
        else
            feedkeys '<Tab>'
        end
    end, {}, { 'i', 's' })

    keymap('<S-Tab>', function()
        if pumvisible() then
            feedkeys '<C-p>'
        elseif vim.snippet.active { direction = -1 } then
            vim.snippet.jump(-1)
        else
            feedkeys '<S-Tab>'
        end
    end, {}, { 'i', 's' })

    keymap('<BS>', '<C-o>s', {}, 's')
end

vim.lsp.enable(servers)
vim.lsp.config(
    "*",
    { on_attach = onAttach }
)

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

vim.keymap.set(
    { "n" },
    "<leader>f",
    function()
        vim.lsp.buf.format()
    end,
    {
        silent = true,
        noremap = true,
        desc = "Lsp format buffer",
    }
)

vim.keymap.set(
    { "n" },
    "<leader>[",
    function()
        vim.diagnostic.jump { count = -1 }
    end,
    {
        silent = true,
        noremap = true,
        desc = "Jump to previous diagnostic",
    }
)

vim.keymap.set(
    { "n" },
    "<leader>]",
    function()
        vim.diagnostic.jump { count = 1 }
    end,
    {
        silent = true,
        noremap = true,
        desc = "Jump to next diagnostic",
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
