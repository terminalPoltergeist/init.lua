vim.keymap.set("n", "<leader>ca", function()
	require("tiny-code-action").code_action()
end, { noremap = true, silent = true })

require("tiny-code-action").setup({
	--- The backend to use, currently only "vim", "delta" and "difftastic" are supported
	backend = "vim",
	backend_opts = {
		delta = {
			-- Header from delta can be quite large.
			-- You can remove them by setting this to the number of lines to remove
			header_lines_to_remove = 4,

			-- The arguments to pass to delta
			-- If you have a custom configuration file, you can set the path to it like so:
			-- args = {
			--     "--config" .. os.getenv("HOME") .. "/.config/delta/config.yml",
			-- }
			args = {
				"--line-numbers",
			},
		},
		difftastic = {
			-- Header from delta can be quite large.
			-- You can remove them by setting this to the number of lines to remove
			header_lines_to_remove = 1,

			-- The arguments to pass to difftastic
			args = {
				"--color=always",
				"--display=inline",
				"--syntax-highlight=on",
			},
		},
	},
	telescope_opts = {
		layout_strategy = "vertical",
        initial_mode = "normal",
		layout_config = {
			width = 0.7,
			height = 0.9,
			preview_cutoff = 1,
			preview_height = function(_, _, max_lines)
				local h = math.floor(max_lines * 0.5)
				return math.max(h, 10)
			end,
		},
	},
	-- The icons to use for the code actions
	-- You can add your own icons, you just need to set the exact action's kind of the code action
	-- You can set the highlight like so: { link = "DiagnosticError" } or  like nvim_set_hl ({ fg ..., bg..., bold..., ...})
	signs = {
		quickfix = { "", { link = "DiagnosticInfo" } },
		others = { "", { link = "DiagnosticWarning" } },
		refactor = { "", { link = "DiagnosticWarning" } },
		["refactor.move"] = { "", { link = "DiagnosticInfo" } },
		["refactor.extract"] = { "", { link = "DiagnosticError" } },
		["source.organizeImports"] = { "", { link = "TelescopeResultVariable" } },
		["source.fixAll"] = { "", { link = "TelescopeResultVariable" } },
		["source"] = { "", { link = "DiagnosticError" } },
		["rename"] = { "", { link = "DiagnosticWarning" } },
		["codeAction"] = { "", { link = "DiagnosticError" } },
	},
})
