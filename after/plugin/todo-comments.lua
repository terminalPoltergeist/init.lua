local colors = require 'terminalPoltergeist.colors'
require'todo-comments'.setup({
    signs = false,
    keywords = {
        TODO = {color = colors.gui0B},
        NOTE = {color = colors.gui0E},
        FIX = {color = colors.gui0A, alt = {"WARN"}},
        DEP = {color = colors.gui0A, alt = {"DEPRECATED"}},
        ERR = {color = colors.gui0F, alt = {"BUG", "XXX"}}
    },
    highlight = {
        after = "",
        before = "",
        keyword = "wide",
    },
})
