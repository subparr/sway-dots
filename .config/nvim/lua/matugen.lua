local M = {}

local generated_path = os.getenv("HOME") .. "/.config/nvim/generated.lua"

function M.source()
    local file = io.open(generated_path, "r")
    if file then
        io.close(file)
        dofile(generated_path)
    else
        local ok = pcall(vim.cmd, 'colorscheme base16-gruvbox-dark-soft')
        if not ok then
            vim.cmd('colorscheme default')
        end
    end
end

local function reload()
    M.source()
    pcall(function()
        require('lualine').setup({
            options = { theme = 'base16' },
        })
    end)
end

M.source()

vim.api.nvim_create_autocmd("Signal", {
    pattern = "SIGUSR1",
    callback = reload,
})

return M
