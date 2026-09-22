return {
    "Wansmer/langmapper.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require('langmapper').setup({})
        require('langmapper').hack_get_keymap()
    end,
}
