local colors = require 'terminalPoltergeist.colors'

vim.g.limelight_default_coefficient = 0.5
vim.g.limelight_paragraph_span = 2
vim.g.limelight_conceal_guifg = colors.gui01
vim.keymap.set('n', '<Leader>ll', ":Limelight!!<CR>")
-- vim.api.nvim_create_autocmd('VimEnter', {pattern = {"*.md", "*.mdx"}, command = "Limelight"})
