-- 事前設定
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.syntax = "on"
vim.opt.signcolumn = "yes"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = "utf-8,sjis,euc-jp"
vim.opt.bomb = false


-- 環境変数から `XDG_CONFIG_HOME` を取得して `runtimepath` に lazy.nvim を追加
local config_home = vim.env.XDG_CONFIG_HOME or vim.fn.stdpath("config")
vim.opt.rtp:prepend(config_home .. "/nvim/lazy/lazy.nvim")

-- -- lazy.nvim 読み込み
require("lazy").setup("plugins")


-- ctrl v でpasteモードにして貼り付けてnopasteに戻す
vim.api.nvim_set_keymap("i", "<C-v>", "<Esc>:set paste<CR>i<C-R>+<Esc>:set nopaste<CR>a", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-c>", '"+y', { noremap = true, silent = true })
