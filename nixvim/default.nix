{
	enable = true;
	colorschemes.kanagawa.enable = true;
	plugins = {
	  # statusline
		lualine.enable = true;
		# lsp stuff
		lsp.enable = true;
		lsp-status.enable = true;
		# git
		fugitive.enable = true;
		# comment blocks (select block and then `gc`)
		comment.enable = true;
		# file explorer
		oil.enable = true;
		# indent even blank lines
		indent-blankline.enable = true;
		# what's this?
		treesitter.enable = true;

	};
	opts = {
		number = true;
		colorcolumn = "80";
		relativenumber = true;
		shiftwidth = 2;
		tabstop = 2;
		wrap = true;
	};
}
