return {
    "ibhagwan/fzf-lua",
    config = function()
        local fzf = require("fzf-lua")

        fzf.setup({
            fzf_opts = { ['--layout'] = 'reverse' },
            files = {
                cwd_prompt = false,
                git_icons = true,
            },
            grep = {
                rg_opts = "--column --line-number --no-heading --color=always --smart-case",
            },
        })

        local root_markers = {
            '.git',
            'Cargo.toml',
            'package.json',
            'go.mod',
            'pyproject.toml',
            'setup.py',
            'Makefile',
            'CMakeLists.txt',
            '.projectroot',
        }

        local function find_project_root()
            local path = vim.fn.expand('%:p:h')
            if path == '' then path = vim.fn.getcwd() end

            local found = vim.fs.find(root_markers, {
                path = path,
                upward = true,
                stop = os.getenv("HOME"),
            })

            if found and #found > 0 then
                return vim.fn.fnamemodify(found[1], ':h')
            end
            return vim.fn.getcwd()
        end

        vim.keymap.set("n", "<leader><leader>", function()
            fzf.files({ cwd = find_project_root() })
        end, { desc = "Files (project root)" })

        vim.keymap.set("n", "<leader>/", function()
            fzf.live_grep({ cwd = find_project_root() })
        end, { desc = "Grep (project root)" })
    end,
}
