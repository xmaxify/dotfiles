return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		-- autopairs
		require("mini.pairs").setup()

		-- surround: sa, sd, sr
		require("mini.surround").setup()

		-- komentarze: gcc, gc
		require("mini.comment").setup()

		-- linia statusu
		require("mini.statusline").setup({
			use_icons = false, -- bez zależności od nerd fonts na serwerze
		})

		-- podświetlanie słowa pod kursorem
		require("mini.cursorword").setup()

		-- ikonki (czysto lua, bez node/nerd fonts wymagane)
		require("mini.icons").setup()
	end,
}
