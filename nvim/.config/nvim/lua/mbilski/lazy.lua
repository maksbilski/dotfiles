local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	require("mbilski.plugins.vimsleuth"),
	require("mbilski.plugins.gitsigns"),
	require("mbilski.plugins.whichkey"),
	require("mbilski.plugins.telescope"),
	require("mbilski.plugins.lazydev"),
	require("mbilski.plugins.vague"),
	require("mbilski.plugins.lsp"),
	require("mbilski.plugins.markview"),
	require("mbilski.plugins.conform"),
	require("mbilski.plugins.todocomments"),
	require("mbilski.plugins.mini"),
	require("mbilski.plugins.treesitter"),
	require("mbilski.plugins.debug"),
	require("mbilski.plugins.lint"),
	require("mbilski.plugins.autopairs"),
	require("mbilski.plugins.gitsigns"),
	require("mbilski.plugins.oil"),
	require("mbilski.plugins.autocomplete"),
	require("mbilski.plugins.indent_line"),
	---	require("mbilski.plugins.fugitive"),
	--  { import = 'custom.plugins' },
})
