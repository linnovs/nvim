local Item = require("nougat.item")
local color = require("catppuccin.palettes").get_palette("macchiato") or {}
local sep = require("nougat.separator")

local lazy = function(opts)
	opts = vim.tbl_extend("force", {
		init = function(item)
			vim.api.nvim_create_autocmd("User", {
				group = vim.api.nvim_create_augroup("nougat.nut.integration.lazy", { clear = true }),
				pattern = { "LazyCheck", "LazyUpdate" },
				callback = function()
					item.value = require("lazy.status").updates()
				end,
			})
		end,
		hidden = function(item)
			return item.value == false
		end,
		hl = { fg = color.peach, bg = color.overlay0 },
		sep_left = sep.left_half_circle_solid(true),
		sep_right = sep.right_half_circle_solid(true),
		prefix = " ",
		content = function(item)
			if item.value == nil then
				item.value = require("lazy.status").updates()
			end
			return item.value
		end,
		suffix = " ",
		on_click = function()
			require("lazy").update()
		end,
	}, opts or {})

	return Item(opts)
end

return lazy
