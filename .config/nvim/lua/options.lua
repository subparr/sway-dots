vim.opt.number = true
vim.opt.cursorline = true
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.copyindent = true
vim.opt.preserveindent = true

vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.showmode = false

vim.g.mapleader = " "
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 1

local ag = vim.api.nvim_create_augroup

vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    group = ag('YankHighlight', { clear = true }),
    callback = function()
        vim.hl.on_yank({ timeout = 170 })
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'netrw',
    callback = function()
        local bind = function(lhs, rhs)
            vim.keymap.set('n', lhs, rhs, { remap = true, buffer = true })
        end
        bind('l', '<CR>')
        bind('h', '-')
    end
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function()
        vim.opt_local.conceallevel = 2
    end
})
