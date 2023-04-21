vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) --Open vim file explorer

-- Makes copy to clipboard on <leader>y
--vim.keymap.set("n", "<leader>y", "\"+y");
--vim.keymap.set("v", "<leader>y", "\"+y");
--vim.keymap.set("n", "<leader>Y", "\"+Y");

-- Move up and down on edit mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("x", "<leader>p", "\"_dP") -- Paste without yanking 

vim.keymap.set({"n", "i"}, "<C-c>", "<esc>") -- Cntrl-p is useless

vim.keymap.set("i", "<C-H>", "<C-w>") -- Windows bind 
vim.keymap.set("i", "<C-BS>", "<C-w>") -- wsl <Cntrl-BackSpace> bind
