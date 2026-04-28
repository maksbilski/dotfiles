return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "n",
			desc = "[F]ormat buffer",
		},
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "v",
			desc = "[F]ormat selection",
		},
		{
			"<leader>tf",
			function()
				vim.g.disable_autoformat = not vim.g.disable_autoformat
				print("Autoformat: " .. (vim.g.disable_autoformat and "OFF" or "ON"))
			end,
			desc = "[T]oggle auto[f]ormat",
		},
	},
	opts = {
		notify_on_error = true,
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat then
				return
			end

			local disable_filetypes = { c = true, cpp = true }
			local lsp_format_opt
			if disable_filetypes[vim.bo[bufnr].filetype] then
				lsp_format_opt = "never"
			else
				lsp_format_opt = "fallback"
			end
			return {
				timeout_ms = 500,
				lsp_fallback = lsp_format_opt,
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff" },
			cpp = { "clang-format" },
			typescript = { "prettier" },
			javascript = { "prettier" },
			typescriptreact = { "prettier" },
			javascriptreact = { "prettier" },
			json = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
			markdown = { "prettier" },
		},
	},
}
