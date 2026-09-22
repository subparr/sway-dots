return {
    'mg979/vim-visual-multi',
    branch = 'master',
    init = function()
        vim.g.VM_maps = {
            ['Add Cursor Up']   = '<C-k>',
            ['Add Cursor Down'] = '<C-j>',
            ['Select All']      = '<C-A>',
        }
    end,
}
