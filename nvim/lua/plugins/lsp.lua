return {
  {
    "neovim/nvim-lspconfig",
    lazy = false, -- 起動時に読み込む（補完などを確実に有効にするため）
    config = function()
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")

      -- lspconfig.denols.setup()

      -- Lua 言語サーバー設定
      lspconfig.lua_ls.setup({
        cmd = { "C:/tools/lua-language-server-3.7.4-win32-x64/bin/lua-language-server.exe" },
        root_dir = function(fname)
          return util.root_pattern(".git", "init.lua", ".luarc.json", ".luarc.jsonc")(fname)
            or vim.fn.stdpath("config")
        end,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }, -- vimグローバルを未定義扱いしない
            },
          },
        },
      })

      -- Go 言語サーバー（gopls）設定
      lspconfig.gopls.setup({})


	-- エラーポップアップ表示キー
	vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { noremap = true, silent = true })
	vim.keymap.set('n', '<leader>q', function()
		vim.diagnostic.setqflist()
	end, { noremap = true, silent = true })
	vim.keymap.set('n', '<leader>c', vim.lsp.buf.code_action, { noremap = true, silent = true })



    end,
  },
}
