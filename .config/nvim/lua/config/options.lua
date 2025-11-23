-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = true -- 相対行番号を有効化
vim.opt.fixendofline = true -- ファイルの最後に改行を追加
vim.opt.endofline = true -- 常に最終行に改行を保つ

-- 背景を透明に
vim.opt.termguicolors = true
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

---
vim.g.lazyvim_rust_diagnostics = "rust-analyzer"

vim.opt.swapfile = false
