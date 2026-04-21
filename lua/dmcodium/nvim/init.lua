local M = {}

function M.setup(opts)
	local config = require('dmcodium.nvim.config')
	config.setup(opts)

	-- Adding .dm, .dme and .dmm as DM language files
	vim.filetype.add({
		extension = {
			dm = "dm",
			dme = "dm",
		}
	})

	-- DreamMaker parser
	-- Register parser for .dm and .dme files
	vim.treesitter.language.register('dm', { 'dm', 'dme' })

	-- Add highlighting for DreamMaker files
	vim.api.nvim_create_autocmd('FileType', {
		pattern = { 'dm', 'dme' },
		callback = function() vim.treesitter.start() end,
	})

	vim.api.nvim_create_autocmd('User', {
		pattern = 'TSUpdate',
		callback = function()
			require('nvim-treesitter.parsers').dm = {
				install_info = config.get_tree_sitter_info(),
			}
		end
	})

	require('nvim-treesitter.install').install({ 'dm' }, true)

	vim.lsp.config('dm', config.get_language_server_info())

	vim.lsp.enable("dm")
end

function M.update()
	require('nvim-treesitter.install').update({ 'dm' }, { summary = true })
end

return M
