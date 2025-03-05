local colors = require('terminalPoltergeist.colors')

vim.api.nvim_set_hl(0, 'IndentLine', { fg = colors.gui01 })

require('ibl').setup({
    indent = {
        char = '·',
        highlight = 'IndentLine'
    }
})
