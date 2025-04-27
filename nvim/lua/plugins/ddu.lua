return {
  {
    "Shougo/ddu.vim",
    lazy = false,
    dependencies = {
      { "vim-denops/denops.vim", lazy = false },
      { "Shougo/ddu-ui-ff", lazy = false },
      { "Shougo/ddu-source-file_rec", lazy = false },
      { "Shougo/ddu-source-file_old", lazy = false },
      { "Shougo/ddu-source-register", lazy = false },
      { "Shougo/ddu-source-buffer", lazy = false },
      { "Shougo/ddu-kind-file", lazy = false },
      { "Shougo/ddu-filter-matcher_substring", lazy = false },
      { "Shougo/ddu-filter-sorter_alpha" },
    },
    config = function()
      vim.fn["ddu#custom#patch_global"]({
        ui = "ff",
        sourceOptions = {
          _ = {
            matchers = { "matcher_substring" },
            sorters = { "sorter_alpha" },
          },
        },
        kindOptions = {
          file = {
            defaultAction = "open",
          },
        },
      })

      -- <leader>f: 全ファイル検索
      vim.api.nvim_set_keymap("n", "<leader>f", "<Cmd>call ddu#start({ 'sources': [{ 'name': 'file_rec' }] })<CR>", { noremap = true, silent = true })

      -- <leader>m: 最近使ったファイル（mr）
      vim.api.nvim_set_keymap("n", "<leader>o", "<Cmd>call ddu#start({ 'sources': [{ 'name': 'file_old' }] })<CR>", { noremap = true, silent = true })

      -- <leader>b: バッファ一覧
      vim.api.nvim_set_keymap("n", "<leader>b", "<Cmd>call ddu#start({ 'sources': [{ 'name': 'buffer' }] })<CR>", { noremap = true, silent = true })

      -- <leader>r: レジスタ
      vim.api.nvim_set_keymap("n", "<leader>r", "<Cmd>call ddu#start({ 'sources': [{ 'name': 'register' }] })<CR>", { noremap = true, silent = true })

      vim.api.nvim_create_autocmd("FileType", {
	      pattern = "ddu-ff",
	      callback = function()
		      -- <CR>でファイルオープン
		      vim.keymap.set("n", "<CR>", function()
			      vim.fn["ddu#ui#do_action"]("itemAction")
		      end, { buffer = true })

		      -- qでクローズ
		      vim.keymap.set("n", "q", function()
			      vim.fn["ddu#ui#do_action"]("quit")
		      end, { buffer = true })

		      -- sでシステムオープン
		      vim.keymap.set("n", "s", function()
			      local items = vim.fn["ddu#ui#get_items"]()
			      local index = vim.fn.line(".")
			      local item = items[index]
			      if item ~= nil then
				      local path = item.word
				      vim.fn.jobstart({ "cmd.exe", "/c", "start", "", path }, { detach = true })
			      end
		      end, { buffer = true })

	      end,
      })

    end,
  },
}

