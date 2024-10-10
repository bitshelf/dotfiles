return {
	"mg979/vim-visual-multi",
	enabled = false,
	-- event = "LazyFile",
	branch = "master",
	init = function()
		vim.cmd([[
			  " noremap <leader>aa <Plug>(VM-Select-All)
			  let g:VM_default_mappings = 0
			  let g:VM_leader                         = {'default': '\', 'visual': '\', 'buffer': '\'}
			  let g:VM_custom_motions                 = {'n': 'h', 'i': 'l', 'u': 'k', 'e': 'j', 'N': '0', 'I': '$', 'h': 'e'}
			  let g:VM_maps = {}
			  let g:VM_maps['Find Under']             = '<C-n>'
			  let g:VM_maps['Find Subword Under']     = '<C-n>'
			  let g:VM_maps["Select Cursor Down"]     = '<M-Down>'      " start selecting down
			  let g:VM_maps["Select Cursor Up"]       = '<M-Up>'        " start selecting up
			  let g:VM_maps["Skip Region"]            = 'q'
			  let g:VM_maps["Remove Region"]          = 'Q'
			  let g:VM_maps["Undo"]                   = 'u'
			  let g:VM_maps["Redo"]                   = '<C-r>'
			  let g:VM_maps["Add Cursor At Pos"]      = '<leader>a'

			  let g:VM_maps["Visual Regex"]           = '\\/'
			  let g:VM_maps["Visual All"]             = '\\A'
			  let g:VM_maps["Visual Add"]             = '\\a'
			  let g:VM_maps["Visual Find"]            = '\\f'
			  let g:VM_maps["Visual Cursors"]         = '\\c'

			  let g:VM_maps["Toggle Block"]           = '\\<BS>'
			  let g:VM_maps["Toggle Single Region"]   = '\\<CR>'
			  let g:VM_maps["Toggle Multiline"]       = '\\M'
		]])
	end
}
