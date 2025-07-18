require("tailwind-tools").setup({
    document_color = {
        enabled = true,      -- can be toggled by commands
        kind = "foreground", -- "inline" | "foreground" | "background"
        debounce = 200,      -- in milliseconds, only applied in insert mode
    },
    conceal = {
        enabled = false,  -- can be toggled by commands
        min_length = nil, -- only conceal classes exceeding the provided length
        symbol = "~",     -- only a single character is allowed
    },
})
