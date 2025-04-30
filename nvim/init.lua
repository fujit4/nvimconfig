-- 事前設定
vim.g.mapleader = " "
vim.o.number = true
vim.o.syntax = "on"
vim.o.signcolumn = "yes"
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"
vim.o.fileencodings = "utf-8,sjis,euc-jp"
vim.o.bomb = false
vim.o.tabstop = 4       -- 画面上のTab幅（見た目）
vim.o.shiftwidth = 4    -- 自動インデント時の幅
vim.o.swapfile = false

-- 環境変数から `XDG_CONFIG_HOME` を取得して `runtimepath` に lazy.nvim を追加
local config_home = vim.env.XDG_CONFIG_HOME or vim.fn.stdpath("config")
vim.opt.rtp:prepend(config_home .. "/nvim/lazy/lazy.nvim")

-- -- lazy.nvim 読み込み
require("lazy").setup("plugins")

-- ctrl v でpasteモードにして貼り付けてnopasteに戻す
vim.api.nvim_set_keymap("i", "<C-v>", "<Esc>:set paste<CR>i<C-R>+<Esc>:set nopaste<CR>a", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-c>", '"+y', { noremap = true, silent = true })
