vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, {desc="File explorer"})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc="Move line down"})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {desc="Move line up"})
vim.keymap.set("n", "J", ":move -2<CR>", {desc="Move line up"})
vim.keymap.set("n", "K", ":move +1<CR>", {desc="Move line down"})

vim.keymap.set({"n", "v"}, "<leader>p", [["+p]], {desc="Paste from clipboard"})
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], {desc="Copy to clipboard"})
