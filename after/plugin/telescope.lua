local telescope = require("telescope")
local builtin = require('telescope.builtin') -- Telescope provides some builtin finding functions
local actions = require('telescope.actions')

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pg', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep)
vim.keymap.set('n', '<leader>pb', builtin.buffers)
vim.keymap.set('n', '<leader>fs', ':Telescope grep_string initial_mode=n search=<C-R><C-W><CR>')

telescope.setup({
    defaults = {
        hidden = true,
        no_ignore = true,
        file_ignore_patterns = {
            ".git", "node_modules"
        },
        results_title = false,
        layout_strategy = "vertical",
        layout_config = {
            vertical = { height = 0.7, preview_height = 0.7 }
        },
        border = true,
        mappings = {
            n = {
                ["dd"] = actions.delete_buffer,
                ["q"] = actions.close,
            },
        }
    },
    pickers = {
        find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
            initial_mode = "normal"
        },
        git_files = {
            initial_mode = "normal"
        },
        buffers = {
            initial_mode = "normal"
        },
        live_grep = {
            find_command = { "rg", "--hidden", "--glob", "!**/.git/*" },
            initial_mode = "insert"
        }
    },
})

require('telescope').load_extension('terraform_doc')
