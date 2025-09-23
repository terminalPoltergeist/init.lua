local api = vim.api

api.nvim_create_augroup("formatting", { clear = true })
api.nvim_create_autocmd({ "BufWritePre" }, {
    group = "formatting",
    callback = function()
        vim.lsp.buf.format()
    end,
})
api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*.html", "*.templ", "*.css", "*.blade.php" },
    group = "formatting",
    callback = function()
        vim.cmd("TailwindSortSync")
    end,
})

api.nvim_create_autocmd('VimEnter',
    { pattern = { "*.ps*", "*.pde" }, command = ":set colorcolumn=115" })
api.nvim_create_autocmd('VimEnter', { command = ":if argc() == 0 | Explore! | endif | set autoindent" })
api.nvim_create_autocmd('VimEnter',
    { pattern = { "*.tf" }, command = ":setlocal commentstring=#\\ %s | setlocal ft=terraform" })
api.nvim_create_autocmd('LspAttach', {
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
    end,
})
