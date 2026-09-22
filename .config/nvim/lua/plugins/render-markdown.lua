return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    opts = {
        heading = {
            enabled = true,
            icons = { '# ', '## ', '### ', '#### ', '##### ', '###### ' },
        },
        checkbox = {
            enabled = true,
            unchecked = { icon = '󰄱 ' },
            checked = { icon = ' ' },
        },
    },
}
