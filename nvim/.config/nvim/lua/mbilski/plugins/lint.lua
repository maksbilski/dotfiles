return {
	{
		"mfussenegger/nvim-lint",
		dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
		config = function()
			local linters = {
				markdown = { "markdownlint" },
				python = { "ruff", "mypy" },
				cpp = { "cpplint" },
				typescript = { "eslint_d" },
				javascript = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				javascriptreact = { "eslint_d" },
			}

			local tools_to_install = {}

			for _, ft_linters in pairs(linters) do
				for _, linter_name in ipairs(ft_linters) do
					table.insert(tools_to_install, linter_name)
				end
			end

			require("mason-tool-installer").setup({
				ensure_installed = tools_to_install,
			})

			local lint = require("lint")
			lint.linters_by_ft = linters

			lint.linters.ruff.args = { "--line-length=120" }
			lint.linters.flake8.args = { "--max-line-length=120" }

			local function get_python_executable_path()
				local venv_path = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
				if venv_path then
					return venv_path .. "/bin/python"
				end
				return vim.fn.exepath("python3") or vim.fn.exepath("python")
			end

			lint.linters.mypy.cmd = "mypy"
			lint.linters.mypy.args = {
				"--python-executable",
				get_python_executable_path(),
				"--show-error-context",
				"--show-column-numbers",
				"--show-error-codes",
			}

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					-- Only run the linter in buffers that you can modify in order to
					-- avoid superfluous noise, notably within the handy LSP pop-ups that
					-- describe the hovered symbol using Markdown.
					if vim.bo.modifiable then
						lint.try_lint()
					end
				end,
			})
		end,
	},
}
