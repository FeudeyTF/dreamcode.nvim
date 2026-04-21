vim.api.nvim_create_user_command('dmupdate', function(args)
	require('dmcodium.nvim').update()
end, {
	nargs = '*',
	bar = true,
	desc = 'Update tree sitter parser for DreamMaker language',
})
