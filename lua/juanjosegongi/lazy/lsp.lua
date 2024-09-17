return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "css_variables",
                "cssls",
                "eslint",
                "tflint",
                "terraformls",
                "gopls",
                "lua_ls",
                "volar",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "vim" },
                                }
                            }
                        }
                    }
                end,
                ["tsserver"] = function()
                    local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
                    local vuels_path = mason_packages .. "/vue-language-server/node_modules/@vue/language-server"

                    local lspconfig = require('lspconfig')

                    lspconfig.tsserver.setup {
                        capabilities = capabilities,
                        root_dir = lspconfig.util.root_pattern(
                            "tsconfig.json",
                            "package.json"
                        ),
                        init_options = {
                            plugins = {
                                {
                                    name = '@vue/typescript-plugin',
                                    location = vuels_path,
                                    languages = { 'vue' },
                                }
                            }
                        },
                        settings = {
                            typescript = {
                                inlayHints = {
                                    includeInlayParameterNameHints = "all",
                                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                                    includeInlayFunctionParameterTypeHints = true,
                                    includeInlayVariableTypeHints = true,
                                    includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                                    includeInlayPropertyDeclarationTypeHints = true,
                                    includeInlayFunctionLikeReturnTypeHints = true,
                                    includeInlayEnumMemberValueHints = true,
                                },
                            },
                        },
                    }
                end,
                ["volar"] = function()
                    local lspconfig = require('lspconfig')

                    lspconfig.volar.setup {
                        capabilities = capabilities,
                        root_dir = lspconfig.util.root_pattern(
                            "vite.config.ts",
                            "vite.config.js",
                            "nuxt.config.ts",
                            "nuxt.config.js"
                        ),
                        init_options = {
                            vue = {
                                hybridMode = false,
                            },
                            typescript = {
                                tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
                            },
                        },
                        settings = {
                            typescript = {
                                inlayHints = {
                                    enumMemberValues = {
                                        enabled = true,
                                    },
                                    functionLikeReturnTypes = {
                                        enabled = true,
                                    },
                                    propertyDeclarationTypes = {
                                        enabled = true,
                                    },
                                    parameterTypes = {
                                        enabled = true,
                                        suppressWhenArgumentMatchesName = true,
                                    },
                                    variableTypes = {
                                        enabled = true,
                                    },
                                },
                            },
                        }
                    }
                end,
                ["gopls"] = function()
                    local lspconfig = require('lspconfig')

                    lspconfig.gopls.setup {
                        capabilities = capabilities,
                        settings = {
                            gopls = {
                                codelenses = {
                                    gc_details = false,
                                    generate = true,
                                    regenerate_cgo = true,
                                    test = true,
                                    run_govulncheck = true,
                                    tidy = true,
                                    upgrade_dependency = true,
                                    vendor = false,
                                },
                                hints = {
                                    assignVariableTypes = true,
                                    compositeLiteralFields = true,
                                    compositeLiteralTypes = true,
                                    constantValues = true,
                                    functionTypeParameters = true,
                                    parameterNames = true,
                                    rangeVariableTypes = true,
                                },
                                analyses = {
                                    fieldalignment = true,
                                    nilness = true,
                                    shadow = true,
                                    unusedparams = true,
                                    unusedwrite = true,
                                    useany = true,
                                },
                                gofumpt = true,
                                semanticTokens = true,
                                usePlaceholders = true,
                                experimentalPostfixCompletions = true,
                                staticcheck = true,
                                completeUnimported = true,
                                directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                            }
                        }
                    }
                end
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'supermaven' },
            }, {
                { name = 'buffer' },
            })
        })

        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                    { name = 'path' }
                },
                {
                    name = 'cmdline',
                    option = {
                        ignore_cmds = { 'Man', '!' }
                    }
                })
        })

        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
