return {
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        config = function()
            vim.lsp.config('*', {
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
            })

            vim.lsp.config('rust_analyzer', {
                settings = {
                    ['rust-analyzer'] = {
                        checkOnSave = true,
                        cargo = { allFeatures = true },
                    },
                },
            })

            vim.lsp.config('lua_ls', {
                settings = {
                    Lua = {
                        runtime = { version = 'LuaJIT' },
                        workspace = {
                            checkThirdParty = false,
                            library = { vim.env.VIMRUNTIME },
                        },
                    },
                },
            })

            vim.lsp.enable({ 'rust_analyzer', 'lua_ls' })

            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(ev)
                    local map = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
                    end
                    map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
                    map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
                    map('n', '<leader>f', function()
                        vim.lsp.buf.format({ async = true })
                    end, 'Format')
                end,
            })
        end,
    },

    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                }, {
                    { name = 'buffer' },
                }),
                mapping = cmp.mapping.preset.insert({
                    ['<C-n>']     = cmp.mapping.select_next_item(),
                    ['<C-p>']     = cmp.mapping.select_prev_item(),
                    ['<C-b>']     = cmp.mapping.scroll_docs(-4),
                    ['<C-f>']     = cmp.mapping.scroll_docs(4),
                    ['<CR>']      = cmp.mapping.confirm({ select = false }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>']     = cmp.mapping.abort(),

                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),

                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
            })
        end,
    },
}
