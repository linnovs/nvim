local ensure_installed = {
	"bash",
	"c",
	"css",
	"csv",
	"diff",
	"dockerfile",
	"git_config",
	"git_rebase",
	"gitattributes",
	"gitcommit",
	"gitignore",
	"go",
	"gomod",
	"gosum",
	"html",
	"http",
	"hurl",
	"hyprlang",
	"ini",
	"javascript",
	"jsdoc",
	"json",
	"json5",
	"just",
	"latex",
	"lua",
	"luadoc",
	"luap",
	"markdown",
	"markdown_inline",
	"nix",
	"proto",
	"python",
	"qmljs",
	"query",
	"rasi",
	"regex",
	"rust",
	"scss",
	"sql",
	"ssh_config",
	"svelte",
	"terraform",
	"toml",
	"tsx",
	"typescript",
	"typst",
	"vim",
	"vimdoc",
	"vue",
	"wgsl",
	"xml",
	"yaml",
	"zig",
}

local max_filesize = 100 * 1024 -- 100 KiB

vim.schedule(function()
	vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
	local TS = require("nvim-treesitter")

	local installed_langs = TS.get_installed()
	local should_install = vim.tbl_filter(function(lang)
		return not vim.tbl_contains(installed_langs, lang)
	end, ensure_installed)

	if #should_install > 0 then
		TS.install(should_install, { summary = true }):await(function()
			installed_langs = TS.get_installed()
		end)
	end

	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("KuugaTSAttach", { clear = true }),
		callback = function(ev)
			local lang = vim.treesitter.language.get_lang(ev.match)
			if not lang or not vim.tbl_contains(installed_langs, lang) then
				return
			end

			local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
			if ok and stats and stats.size < max_filesize then
				pcall(vim.treesitter.start, ev.buf)
			end

			vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.wo.foldmethod = "expr"

			if not vim.g.disable_treesitter_indent then
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
		end,
	})
end)
