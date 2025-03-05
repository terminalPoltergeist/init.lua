vim.api.nvim_create_autocmd('BufEnter', {pattern = {"*.md", "*.mdx"}, command = ":Pencil"})
vim.cmd('let g:pencil#conceallevel = 2')
vim.cmd('let g:pencil#concealcursor = ""')
vim.cmd('let g:pencil#wrapModeDefault = "soft"')
vim.cmd('let g:pencil#cursorwrap = 0')
