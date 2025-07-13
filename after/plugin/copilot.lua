vim.cmd('Copilot disable')
local copilot_enabled = false
vim.keymap.set('n', '<leader>cp', function()
    if copilot_enabled then
        vim.cmd('Copilot disable')
        print("Copilot OFF")
    else
        vim.cmd('Copilot enable')
        print("Copilot ON")
    end
    copilot_enabled = not copilot_enabled
end)
