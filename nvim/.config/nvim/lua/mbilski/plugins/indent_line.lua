return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		indent = {
			char = "│",
		},
		scope = {
			enabled = true,
			char = "▎",
			show_start = true,
			show_end = true,
			highlight = { "IblScopeVertical", "IblScopeHorizontal" },
		},
	},
	config = function(_, opts)
		local hooks = require("ibl.hooks")

		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			-- Kolory z palety motywu vague lub dobrze pasujące odcienie:
			local vague_red = "#E76F51" -- Czerwony z vague (dla podkreśleń)
			local vague_yellow = "#e9c46a" -- Ciepły, musztardowy żółty/pomarańczowy dla pionowej linii

			-- Definicja grupy podświetlania dla pionowej linii zakresu (nowy kolor)
			vim.api.nvim_set_hl(0, "IblScopeVertical", { fg = vague_yellow })

			-- Definicja grupy podświetlania dla poziomych podkreśleń (czerwony z vague)
			vim.api.nvim_set_hl(0, "IblScopeHorizontal", { sp = vague_red, underline = true })
		end)

		require("ibl").setup(opts)
	end,
}
