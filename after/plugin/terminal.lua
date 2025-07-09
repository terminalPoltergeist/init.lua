local state = {
    container = {
        buf = -1,
        win = -1,
    },
    floating = {
        buf = -1,
        win = -1,
    }
}

local function create_floating_window(opts)
    opts = opts or {}
    local padding = opts.padding or { x = 4, y = 1 }
    local total_width = opts.width or math.floor(vim.o.columns * 0.8)
    local total_height = opts.height or math.floor(vim.o.lines * 0.8)

    -- Calculate centered position
    local col = math.floor((vim.o.columns - total_width) / 2)
    local row = math.floor((vim.o.lines - total_height) / 2)

    local container_buf = vim.api.nvim_create_buf(false, true)

    local container_win = vim.api.nvim_open_win(container_buf, true, {
        relative = "editor",
        width = total_width,
        height = total_height,
        col = col,
        row = row,
        border = "rounded",
        style = "minimal",
    })

    local term_width = total_width - padding.x
    local term_height = total_height - padding.y

    -- Create a buffer
    local term_buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        term_buf = opts.buf
    else
        term_buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
    end

    local term_win = vim.api.nvim_open_win(term_buf, true, {
        relative = "win",
        win = container_win,
        width = term_width,
        height = term_height,
        col = math.floor(padding.x / 2),
        row = math.floor(padding.y / 2),
        style = "minimal",
        border = "none",
    })

    return {
        container = { buf = container_buf, win = container_win },
        floating = { buf = term_buf, win = term_win },
    }
end

local toggle_terminal = function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        vim.cmd('startinsert')
        local result = create_floating_window {
            buf = state.floating.buf,
        }
        state.container = result.container
        state.floating = result.floating

        if vim.bo[state.floating.buf].buftype ~= "terminal" then
            vim.cmd.terminal()
        end
    else
        vim.api.nvim_win_close(state.floating.win, true)
        if vim.api.nvim_win_is_valid(state.container.win) then
            vim.api.nvim_win_close(state.container.win, true)
        end
    end
end

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>") -- go to normal mode in terminal
vim.keymap.set({ "n", "t" }, "<Leader><Leader>", toggle_terminal)
