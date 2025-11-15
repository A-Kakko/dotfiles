-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "d", '"_d')
vim.keymap.set("n", "D", '"_D')
vim.keymap.set("x", "d", '"_d')
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("n", "C", '"_C')
vim.keymap.set("n", "s", '"_s')
vim.keymap.set("n", "S", '"_S')
vim.keymap.set("x", "c", '"_c')
vim.keymap.set("x", "C", '"_C')
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "X", '"d')
vim.keymap.set("x", "x", '"_x')
vim.keymap.set("n", "X", '"d')

vim.keymap.set("n", "p", "p`]", { desc = "Paste and move to the end" })
vim.keymap.set("n", "P", "P`]", { desc = "Paste and move to the end" })
