local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local limitStr = function(str)
	if #str > 25 then
		str = string.sub(str, 1, 22) .. "..."
	end
	return str
end

local setCompHL = function()
	local fgdark = "#2E3440"

	vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
	vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
	vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })

	vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#808080", bg = "NONE", italic = true })
	vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = fgdark, bg = "#B5585F" })
	vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = fgdark, bg = "#B5585F" })
	vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = fgdark, bg = "#B5585F" })

	vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = fgdark, bg = "#9FBD73" })
	vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = fgdark, bg = "#9FBD73" })
	vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = fgdark, bg = "#9FBD73" })

	vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = fgdark, bg = "#D4BB6C" })
	vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = fgdark, bg = "#D4BB6C" })
	vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = fgdark, bg = "#D4BB6C" })

	vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = fgdark, bg = "#A377BF" })
	vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = fgdark, bg = "#A377BF" })
	vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = fgdark, bg = "#A377BF" })
	vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = fgdark, bg = "#A377BF" })
	vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = fgdark, bg = "#A377BF" })

	vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = fgdark, bg = "#7E8294" })
	vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = fgdark, bg = "#7E8294" })

	vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = fgdark, bg = "#D4A959" })
	vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = fgdark, bg = "#D4A959" })
	vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = fgdark, bg = "#D4A959" })

	vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = fgdark, bg = "#6C8ED4" })
	vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = fgdark, bg = "#6C8ED4" })
	vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = fgdark, bg = "#6C8ED4" })

	vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = fgdark, bg = "#58B5A8" })
	vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = fgdark, bg = "#58B5A8" })
	vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = fgdark, bg = "#58B5A8" })
end

return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",

		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/nvim-cmp",
			-- "hrsh7th/cmp-nvim-lua",
			-- "hrsh7th/cmp-calc",
			-- "SirVer/ultisnips",
			-- {
			-- 	"L3MON4D3/LuaSnip",
			-- 	event = "LazyFile",
			-- 	-- follow latest release.
			-- 	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- 	-- install jsregexp (optional!).
			-- 	build = (not LazyVim.is_win()) and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp" or nil,
			--
			--     opts = {
			-- 	  history = true,
			-- 	  delete_check_events = "TextChanged",
			-- 	},
			-- },
			{
				"onsails/lspkind.nvim",
				lazy = false,
				config = function()
					require("lspkind").init()
				end
			},
		},

			---@param opts cmp.ConfigSchema
			opts = function(_, opts)

				-- local luasnip = require("luasnip")
				local cmp = require("cmp")

				opts.mapping = vim.tbl_extend("force", opts.mapping, {
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							-- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
							cmp.select_next_item()
							-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
							-- this way you will only jump inside the snippet region
						-- elseif luasnip.expand_or_jumpable() then
						-- 	luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						-- elseif luasnip.jumpable(-1) then
						-- 	luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				})
			end,

		config = function()
			local lspkind = require("lspkind")
			vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
			local cmp = require("cmp")
			-- local luasnip = require("luasnip")

			local fgdark = "#2E3440"

			setCompHL()
			cmp.setup({
				preselect = cmp.PreselectMode.None,
				-- snippet = {
				-- 	expand = function(args)
				-- 		-- luasnip.lsp_expand(args.body)
				-- 		-- vim.fn["UltiSnips#Anon"](args.body)
				-- 	end,
				-- },
				window = {
					completion = {
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
						col_offset = -3,
						side_padding = 0,
					},
					documentation = cmp.config.window.bordered(),
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					maxwidth = 60,
					maxheight = 10,
					format = function(entry, vim_item)
						local kind = lspkind.cmp_format({
							mode = "symbol_text",
							symbol_map = { Codeium = "", },
						})(entry, vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = limitStr(entry:get_completion_item().detail or "")

						return kind
					end,
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "nvim_lua" },
					{ name = "treesitter" },
					{ name = "spell" },
					-- { name = "calc" },
					-- { name = "luasnip" },
					-- { name = 'tmux',    option = { all_panes = true, } },  -- this is kinda slow
				}),
				mapping = cmp.mapping.preset.insert({
					['<A-o>'] = cmp.mapping.complete(),
					['<c-f>'] = cmp.mapping({
						i = function(fallback)
							cmp.close()
							fallback()
						end
					}),
					['<c-y>'] = cmp.mapping({ i = function(fallback) cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert }) end }),
					['<CR>'] = cmp.mapping({
						i = function(fallback)
							if cmp.visible() and cmp.get_active_entry() then
								cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
							else
								fallback()
							end
						end
					}),
					["<Tab>"] = cmp.mapping({
						i = function(fallback)
							if cmp.visible() then
								cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
							elseif has_words_before() then
								cmp.complete()
							else
								fallback()
							end
						end,
					}),
					["<S-Tab>"] = cmp.mapping({
						i = function(fallback)
							if cmp.visible() then
								cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
							else
								fallback()
							end
						end,
					}),
				}),
			})
		end,
	},
}
