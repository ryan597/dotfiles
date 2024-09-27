return {
	{ "echasnovski/mini.nvim", version = false }, -- 40+ other plugins

	{ "tpope/vim-sleuth" }, -- Detect tabstop and shiftwidth automatically

	{ "ellisonleao/gruvbox.nvim" }, -- theme

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = { theme = "gruvbox" },
	},
}
