-- TODO: check out configs at https://lsp-zero.netlify.app/docs/getting-started.html#plot-twist

vim.diagnostic.config({
    virtual_text = true,
    float = {
        border = "rounded",
    },
})

-- local on_attach = function(client, bufnr)
--     -- Enable completion triggered by <c-x><c-o>
--     vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--     -- Mappings to magical LSP functions!
--     local bufopts = { noremap = true, silent = true, buffer = bufnr }
--     vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
--     vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
--     vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
--     vim.keymap.set('n', 'gk', vim.lsp.buf.hover, bufopts)
--     vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
--     vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, bufopts)
--     vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
--     vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
--     vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
--     vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, bufopts)
-- end

vim.keymap.set('n', 'K', function()
    vim.lsp.buf.hover({
        border = 'rounded'
    })
end)

-- vim.opt.signcolumn = 'no'

-- vim.lsp.util.default_config.capabilities = vim.tbl_deep_extend(
--     'force',
--     vim.lsp.util.default_config.capabilities,
--     capabilities
-- )

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, cmp_capabilities)

vim.lsp.enable('lua_ls', {
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
                globals = { "vim", "require" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})

vim.lsp.config('terraformls', {
    capabilities = capabilities,
    cmd = { "terraform-ls", "serve" },
    filetypes = { "terraform", "tf", "terraform-vars" },
    init_options = {
        experimentalFeatures = {
            prefillRequiredFields = true,
        },
    },
    on_attach = function()
        require('telescope').load_extension('terraform_doc')
        vim.keymap.set("n", "<Leader>td", ":Telescope terraform_doc full_name=hashicorp/azurerm<CR>",
            { noremap = true, silent = true })
    end,
})
vim.lsp.enable('terraformls')

-- WARN: ~/.local/state/nvim/lsp.log shows "cannot start pylsp due to config error: .../Cellar/neovim/0.11.4/share/nvim/runtime/lua/vim/lsp.lua:485: cmd: expected expected function or table with executable command, got table: 0x010a372740. Info: pylsp is not executable"
-- vim.lsp.enable('pylsp', {
--     capabilities = capabilities,
--     settings = {
--         pylsp = {
--             plugins = {
--                 pycodestyle = {
--                     ignore = { 'W391', 'E722', 'E231', 'E501', 'E401' },
--                     maxLineLength = 100
--                 }
--             }
--         }
--     }
-- })

-- require("lspconfig").clangd.setup({
--   capabilities = capabilities,
--     on_attach = function(client, bufnr)
--         client.server_capabilities.signatureHelpProvider = false
--     end,
-- })

vim.lsp.enable('ansiblels', {
    capabilities = capabilities,
    root_markers = { '.git' },
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

vim.lsp.enable('html', {
    capabilities = capabilities,
    filetypes = { "html", "blade", "markdown" },
    settings = {
        html = {
            format = {
                -- wrapLineLength = 0 -- don't auto-split long html lines into multiple lines
            }
        }
    }
})

-- vim.lsp.enable('htmx', {
--     capabilities = capabilities,
--     filetypes = { "html", "templ" }
-- })

vim.lsp.enable('cssls', {
    capabilities = capabilities,
    settings = {
        css = {
            validate = true,
            lint = { unknownAtRules = "ignore" },
        },
        scss = {
            validate = true,
        },
        less = {
            validate = true,
        },
    }
})

vim.lsp.enable('tailwindcss', {
    capabilities = capabilities,
    filetypes = { "html", "templ", "css", "blade" },
    init_options = { userLanguages = { templ = "html" } },
})

vim.lsp.enable('gopls', {
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
    root_markers = { 'go.mod' },
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

vim.lsp.enable('templ', {
    capabilities = capabilities,
})

vim.lsp.enable('ts_ls', {
    filetypes = { "templ" },
    on_attach = on_attach,
    capabilities = capabilities
})

vim.lsp.enable('eslint', {
    filetypes = { "templ" },
    on_attach = on_attach,
    capabilities = capabilities
})

vim.lsp.config('powershell_es', {
    capabilities = capabilities,
    bundle_path = '/Users/jack/.local/share/powershell/PowerShellEditorServices',
    shell = '/usr/local/bin/pwsh',
    settings = {
        powershell = {
            codeFormatting = {
                addWhitespaceAroundPipe = true,
                alignPropertyValuePairs = true,
                autoCorrectAliases = false,
                avoidUsingSemicolons = false,
                ignoreOneLineBlock = true,
                newLineAfterCloseBrace = false,
                newLineAfterOpenBrace = true,
                openBraceOnSameLine = true,
                pipelineIdentationStyle = 'NoIndentation',
                trimWhitespaceAroundPipe = false,
                useConsistentStrings = false,
                useCorrectcase = true,
                whitespaceAfterSeparator = true,
                whitespaceAroundOperator = true,
                whitespaceAroundPipe = true,
                whitespaceBeforeOpenBrace = true,
                whitespaceBeforeOpenParen = true,
                whitespaceBetweenParameters = false,
                whitespaceInsideBraces = true,
            }
        }
    }
})

vim.lsp.enable('powershell_es')

vim.lsp.enable('jsonls', {
    capabilities = capabilities,
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true }
        }
    }
})

vim.lsp.enable('marksman', {})
-- vim.lsp.enable('phpactor', {
--     capabilities = capabilities,
-- })
vim.lsp.enable('intelephense', {
    filetypes = { "php" },
    commands = {
        IntelephenseIndex = {
            function()
                vim.lsp.buf.execute_command({ command = 'intelephense.index.workspace' })
            end,
        },
    },
    settings = {
        intelephense = {
            files = {
                maxSize = 5000000,
            },
            diagnostics = {
                enable = true,
            },
            telemetry = {
                enable = false,
            },
        },
    },
    capabilities = capabilities,
    on_attach = vim.api.nvim_create_autocmd(
        "BufWritePre",
        {
            pattern = "*.php",
            callback = function()
                vim.cmd("let view = winsaveview() | silent! %s/fn(/fn (/g | call winrestview(view)")
            end,
        }
    )
})

vim.lsp.enable('pbls', {
    default_config = {
        cmd = { '/Users/jack/.cargo/bin/pbls' },
        filetypes = { 'proto' }
    }
})

-- require('lspconfig').pbls.setup({})

-- WARN: ~/.local/state/nvim/lsp.log showing "protobuf_language_server does not have a configuration"
-- vim.lsp.enable('protobuf_language_server', {
--     default_config = {
--         cmd = { '/Users/jack/go/bin/protobuf-language-server', '-logs', '/Users/jack/.local/state/nvim/.protobuf-language-server.log' },
--         filetypes = { 'proto' },
--         root_markers = { '.git' },
--         -- single_file_support = true,
--     }
-- })

vim.lsp.enable('sqlls', {
    default_config = {
        cmd = { 'sql-language-server', 'up', '--method', 'stdio' },
        filetypes = { 'sql' },
        root_markers = { '.git' },
    }
})
vim.lsp.enable('sqlls', {})

vim.lsp.enable('yamlls', {})

vim.lsp.enable('dockerls', {})

vim.lsp.enable('ts_ls', {
    default_config = {
        init_options = { hostInfo = 'neovim' },
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = {
            'javascript',
            'javascriptreact',
            'javascript.jsx',
            'typescript',
            'typescriptreact',
            'typescript.tsx',
        },
        root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
        single_file_support = true,
    },
})

vim.lsp.enable('nil_ls', {
    autostart = true,
    capabilities = capabilities,
})

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
