-- TODO: check out configs at https://lsp-zero.netlify.app/docs/getting-started.html#plot-twist
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lsp = require("lspconfig")

vim.diagnostic.config({
    virtual_text = true
})

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- Mappings to magical LSP functions!
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gk', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- vim.opt.signcolumn = 'no'

local lspconfig_defaults = lsp.util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

require("lspconfig").lua_ls.setup({
    capabilities = capabilities,
    -- on_attach = custom_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                -- path = ,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                -- library = api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})

require("lspconfig").pylsp.setup {
    capabilities = capabilities,
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = { 'W391', 'E722', 'E231', 'E501', 'E401' },
                    maxLineLength = 100
                }
            }
        }
    }
}

-- require("lspconfig").clangd.setup({
--   capabilities = capabilities,
--     on_attach = function(client, bufnr)
--         client.server_capabilities.signatureHelpProvider = false
--     end,
-- })

require("lspconfig").terraformls.setup({
    capabilities = capabilities,
    cmd = { "terraform-ls", "serve" },
    filetypes = { "terraform", "tf", "terraform-vars" },
    on_attach = function()
        require("treesitter-terraform-doc").setup({})
        vim.keymap.set("n", "<Leader>od", ":OpenDoc<CR>", { noremap = true, silent = true })
    end,
})

require("lspconfig").ansiblels.setup({
    capabilities = capabilities,
    root_dir = require('lspconfig.util').root_pattern('.git'),
    settings = {
        ansible = {
            validation = {
                lint = {
                    enabled = false,
                }
            }
        }
    }
})

require("lspconfig").html.setup({
    capabilities = capabilities,
    filetypes = { "html", "templ", "blade" },
})

require("lspconfig").htmx.setup({
    capabilities = capabilities,
    filetypes = { "html", "templ" }
})

require("lspconfig").cssls.setup({
    capabilities = capabilities
})

require("lspconfig").tailwindcss.setup({
    capabilities = capabilities,
    filetypes = { "html", "templ", "css", "blade" },
    init_options = { userLanguages = { templ = "html" } }
})

require("lspconfig").gopls.setup({
    capabilities = capabilities,
    -- on_attach = function(client, bufnr)
    --   -- require("shared").on_attach(client, bufnr)

    --   vim.api.nvim_create_autocmd("BufWritePre", {
    --     pattern = {
    --       "*.go"
    --     },
    --     command = [[lua OrgImports(1000)]]
    --   })
    -- end,
    cmd = { "gopls" },
    filetypes = { "go", "templ" },
    root_dir = require('lspconfig.util').root_pattern { "go.mod" },
    settings = {
        gopls = {
            analyses = {
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
            },
            experimentalPostfixCompletions = true,
            gofumpt = true,
            staticcheck = true,
            usePlaceholders = false,
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            }
        },
    },
})

require("lspconfig").templ.setup({
    capabilities = capabilities,
})

require("lspconfig").ts_ls.setup({
    filetypes = { "templ" },
    on_attach = on_attach,
    capabilities = capabilities
})

require("lspconfig").eslint.setup({
    filetypes = { "templ" },
    on_attach = on_attach,
    capabilities = capabilities
})

require("lspconfig").powershell_es.setup {
    capabilities = capabilities,
    bundle_path = '~/.local/share/powershell/PowerShellEditorServices',
    shell = '/usr/local/bin/pwsh'
}

require("lspconfig").jsonls.setup {
    capabilities = capabilities,
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true }
        }
    }
}

require("lspconfig").marksman.setup({})
require("lspconfig").phpactor.setup({})
require('lspconfig').intelephense.setup({
    filetypes = { "php" },
    commands = {
        IntelephenseIndex = {
            function()
                vim.lsp.buf.execute_command({ command = 'intelephense.index.workspace' })
            end,
        },
    },
    on_attach = function(client, bufnr)
        -- client.server_capabilities.documentFormattingProvider = false
        -- client.server_capabilities.documentRangeFormattingProvider = false
        -- if client.server_capabilities.inlayHintProvider then
        --   vim.lsp.buf.inlay_hint(bufnr, true)
        -- end
    end,
    capabilities = capabilities
})

-- require('lspconfig.configs').pbls = {
--     default_config = {
--         cmd = { '/Users/jack/.cargo/bin/pbls' },
--         filetypes = { 'proto' }
--     }
-- }

-- require('lspconfig').pbls.setup({})

require("lspconfig.configs").protobuf_language_server = {
    default_config = {
        cmd = { '/Users/jack/go/bin/protobuf-language-server', '-logs', '/Users/jack/.local/state/nvim/.protobuf-language-server.log' },
        filetypes = { 'proto' },
        root_dir = require('lspconfig.util').root_pattern('.git'),
        -- single_file_support = true,
    }
}

require('lspconfig').protobuf_language_server.setup({})

require("lspconfig.configs").sqlls = {
    default_config = {
        cmd = { 'sql-language-server', 'up', '--method', 'stdio' },
        filetypes = { 'sql' },
        root_dir = require('lspconfig.util').root_pattern('.git'),
    }
}
require('lspconfig').sqlls.setup({})

require('lspconfig').yamlls.setup({})

require('lspconfig').dockerls.setup({})

-- require('lspconfig.configs').alpinejsls = {
--     default_config = {
--         cmd = { 'alpinejs-language-server', '--stdio' },
--         filetypes = { 'blade', 'html' },
--         root_dir = require('lspconfig.util').root_pattern('.git'),
--     }
-- }
-- require('lspconfig').alpinejsls.setup({})

-- require('lspconfig.configs').buf_lsp = {
--     default_config = {
--         cmd = { 'buf', 'beta', 'lsp' },
--         filetypes = { 'proto' },
--         root_dir = function(fname)
--             return lsp.util.find_git_ancestor(fname)
--         end,
--         settings = {},
--     }
-- }
