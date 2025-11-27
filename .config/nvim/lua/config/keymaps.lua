-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- jjでインサートモードを抜ける
local Util = require("lazyvim.util")
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
-- x, d, c, s でレジスタに保存しない（ブラックホールレジスタ使用）
vim.keymap.set({ "n", "v" }, "x", '"_x', { desc = "Delete char without yank" })
vim.keymap.set({ "n", "v" }, "d", '"_d', { desc = "Delete without yank" })
vim.keymap.set({ "n", "v" }, "c", '"_c', { desc = "Change without yank" })
vim.keymap.set({ "n", "v" }, "s", '"_s', { desc = "Substitute without yank" })

-- X（大文字）はレジスタに保存（通常の動作）
vim.keymap.set({ "n", "v" }, "X", "d", { desc = "Cut to register" })
vim.keymap.set("n", "<leader>ce", vim.diagnostic.open_float, { desc = "Show diagnostic error" })

-- dd, cc も無名レジスタに保存しない
vim.keymap.set("n", "dd", '"_dd', { desc = "Delete line without yank" })
vim.keymap.set("n", "cc", '"_cc', { desc = "Change line without yank" })

-- Jでなにもしない
vim.keymap.set("n", "J", "", { desc = "None" })

-- ターミナルにボーダーを追加する。
local lazyterm = function()
  Util.terminal(nil, { cwd = Util.root(), border = "rounded" })
end
vim.keymap.set("n", "<leader>ft", lazyterm, { desc = "Terminal (root dir)" })
vim.keymap.set("n", "<C-/>", lazyterm, { desc = "Terminal (root dir)" })
vim.keymap.set("n", "<C-_>", lazyterm, { desc = "which_key_ignore" })
vim.keymap.set({ "n", "x" }, "s", "<Nop>")
vim.keymap.set("i", "<C-CR>", function()
  require("in-and-out").in_and_out()
end)
vim.keymap.set("n", "gr", "<cmd>Lspsaga lsp_finder<CR>")
vim.keymap.set("n", "<leader>ce", "<cmd>Lspsaga show_line_diagnostics<CR>")
vim.keymap.set("n", "<leader>ce", vim.diagnostic.open_float, { desc = "Show diagnostic error" })
