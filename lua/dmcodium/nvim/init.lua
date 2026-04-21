local M = {}

function M.setup(opts)
	local config = require('dmcodium.nvim.config')
	conig.setup(opts)

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

	require('nvim-treesitter.parsers').dm = {
		install_info = config.get_tree_sitter_info(),
	}

	require('nvim-treesitter.install').install({ "dm" }, { summary = true })

	-- LSP config for DreamMaker language server
	vim.lsp.config['dm'] = {
		-- Command, that will start language server
		cmd = { 'dm-langserver' },
		filetypes = { 'dm' },
		root_markers = { 'SpacemanDMM.toml', '.git' },
		settings = {},
	}

	vim.lsp.enable("dm")
end

function M.update()
	require('nvim-treesitter.install').update({ 'dm' }, { summary = true })
end

return M
