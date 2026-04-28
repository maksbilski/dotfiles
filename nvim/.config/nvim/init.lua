require("mbilski")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
--
vim.api.nvim_create_augroup("CMakeSettings", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "CMakeSettings",
	pattern = "cmake",
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.expandtab = true
	end,
})

-- Tworzy grupę, aby uniknąć duplikowania autocommandu przy przeładowywaniu konfiguracji
vim.api.nvim_create_augroup("CppIndentSettings", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = "CppIndentSettings",
	pattern = "cpp",
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.expandtab = true
	end,
})
