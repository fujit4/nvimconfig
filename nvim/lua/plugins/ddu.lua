return {
  {
    "Shougo/ddu.vim",
    lazy = false,
    dependencies = {
      { "vim-denops/denops.vim", lazy = false },
      { "Shougo/ddu-ui-ff", lazy = false },
      { "Shougo/ddu-source-file_rec", lazy = false },
      { "Shougo/ddu-source-file_mr", lazy = false },
      { "Shougo/ddu-source-register", lazy = false },
      { "Shougo/ddu-source-buffer", lazy = false },
      { "Shougo/ddu-filter-matcher_substring", lazy = false },
      { "Shougo/ddu-kind-file", lazy = false },
      { "Shougo/ddu-filter-sorter_alpha" },
    },
    config = function()
      vim.fn["ddu#custom#patch_global"]({
        ui = "ff",
        sources = {
          { name = "file_rec" },
	  { name = "file_mr", params = { kind = "file" } },
	  { name = "register" },
	  { name = "buffer" },
        },
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

      -- <leader>fでファイルリストを開く
      vim.api.nvim_set_keymap("n", "<leader>f", "<Cmd>call ddu#start({})<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>fb", "<Cmd>call ddu#start({ 'sources': [{'name': 'buffer'}] })<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>fr", "<Cmd>call ddu#start({ 'sources': [{'name': 'register'}] })<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>fm", "<Cmd>call ddu#start({ 'sources': [{'name': 'file_mr', 'params': {'kind': 'file'}}] })<CR>", { noremap = true, silent = true })

      -- <CR>でファイルオープン
      vim.api.nvim_create_autocmd("FileType", {
	      pattern = "ddu-ff",
	      callback = function()
		      vim.keymap.set("n", "<CR>", function()
			      vim.fn["ddu#ui#do_action"]("itemAction")
		      end, { buffer = true })

		      vim.keymap.set("n", "q", function()
			      vim.fn["ddu#ui#do_action"]("quit")
		      end, { buffer = true })
	      end,
      })
    end,
  },
}

