local map = vim.keymap.set

-- fm, try finding something emacs like to allow for easier fm, netrw has awful keybinds
map("n", "<leader>e", "<Cmd>Ex<CR>")


map('n', '<leader>u', '<CMD>UndotreeToggle<CR><CMD>UndotreeFocus<CR>', { silent = true })

map('n', '<Enter>', 'm`o<Esc>``', { desc = 'New line below' })
map('n', '<S-Enter>', 'm`O<Esc>``', { desc = 'New line above' })

map('n', '<leader>rc', '<CMD>!cargo check<CR>',  { desc = 'Cargo check' })
map('n', '<leader>rb', '<CMD>!cargo build<CR>',  { desc = 'Cargo build --release' })
map('n', '<leader>rr', '<CMD>!cargo run<CR>',    { desc = 'Cargo run' })
map('n', '<leader>rt', '<CMD>!cargo test<CR>',   { desc = 'Cargo test' })
map('n', '<leader>rf', '<CMD>!cargo fmt<CR>',    { desc = 'Cargo fmt' })
map('n', '<leader>rl', '<CMD>!cargo clippy<CR>', { desc = 'Cargo clippy' })


map('n', '<leader>K', vim.lsp.buf.hover, { desc = 'LSP hover' })

