function ColorMyPencils(transparent, color)
	color = color or "rose-pine";
	vim.cmd.colorscheme(color);

	if transparent then
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end
end

ColorMyPencils(false)
