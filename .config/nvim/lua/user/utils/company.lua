local M = {}

local google3_home = '/google/src/cloud/delay/'

function M.setup()
    local google3_filetype_group = vim.api.nvim_create_augroup('Google3Filetype', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
        group = google3_filetype_group,
        pattern = { google3_home .. '*.java', google3_home .. '*.kt' },
        command = 'set sw=2 ts=2 sts=2 tw=100',
    })
end

function M.is_corporate_host()
    return vim.loop.fs_stat(google3_home) ~= nil
end

function M.setup_lsp(capabilities)
    -- TODO: re-enable this.
    -- Custom configuration for CiderLSP.
    require 'lspconfig.configs'.ciderlsp = {
        default_config = {
            cmd = {
                '/google/bin/releases/cider/ciderlsp/ciderlsp',
                '--tooltag=nvim-lsp',
                '--noforward_sync_responses',
                '--websocket_host=ciderlsp-staging.corp.google.com',
            },
            filetypes = {
                'c',
                'cpp',
                'java',
                'kotlin',
                'proto',
                'textproto',
                'go',
                'python',
                'bzl',
                'objc',
                'typescript',
                'javascript',
            },
            root_dir = function(fname)
                return string.match(fname, '(/google/src/cloud/[%w_-]+/[%w_-]+/google3/).+$')
            end,
            settings = {},
        },
    }
    require 'lspconfig'.ciderlsp.setup {
        capabilities = capabilities,
        on_attach = M.user_on_attach,
    }
end

return M
