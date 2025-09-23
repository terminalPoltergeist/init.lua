local key = vim.keymap

vim.g.mapleader = " "

-- netrw
key.set("n", "<leader>ff", vim.cmd.Ex)

-- quicker escape
key.set("i", "jj", "<esc>")

-- open new buffer with file under cursor
key.set("", "gf", ":edit <cfile><cr> | :set concealcursor=v<cr>", { silent = true })

-- toggle spell checking
key.set("", "<Leader>s", ":call ToggleSpellCheck()<CR>", { noremap = true, silent = true })

-- yank entire line after cursor
key.set("", "Y", "y$")

-- half-page jumps and centers
key.set("", "<C-u>", "<C-u>zz")
key.set("", "<C-d>", "<C-d>zz")

-- next/previous search centers
key.set("n", "n", "nzzzv")
key.set("n", "N", "Nzzzv")

-- move entire visual block selection
key.set("v", "J", ":m '>+1<CR>gv=gv")
key.set("v", "K", ":m '<-2<CR>gv=gv")

-- paste and keep original selection in paste buffer
key.set("x", "<leader>p", "\"_dP")

-- make "jump to mark" go to horizontal location too
key.set("n", "'", "`", { noremap = true, silent = true })

key.set("", "<Leader>lb", ":set linebreak<CR>", { noremap = true })
key.set("", "<Leader>nb", ":set nolinebreak<CR>", { noremap = true })

key.set("n", "<Leader>hs", ":split<CR>", { noremap = true, silent = true })
key.set("n", "<Leader>vs", ":vsplit<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>d[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>d]', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>Telescope diagnostics<CR>', { noremap = true, silent = true })
