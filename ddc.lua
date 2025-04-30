
return {
  {
    "Shougo/ddc.vim",
    lazy = false,
    dependencies = {
      { "vim-denops/denops.vim", lazy = false },
      { "Shougo/ddc-ui-pum", lazy = false },
      { "Shougo/ddc-source-lsp", lazy = false },
      { "uga-rosa/ddc-source-lsp-setup", lazy = false },
      { "Shougo/ddc-source-around", lazy = false },
      { "Shougo/ddc-filter-matcher_head", lazy = false },
      { "Shougo/ddc-filter-sorter_rank", lazy = false },
      { "Shougo/ddc-filter-converter_remove_overlap", lazy = false },
      { "Shougo/pum.vim", lazy = false },
    },
    config = function()
	    require("ddc_source_lsp_setup").setup()

      vim.fn["ddc#custom#patch_global"]({
	      ui = "pum",
	      sources = { "lsp", "around" },
	      sourceOptions = {
		      _ = {
			      matchers = { "matcher_head" },
			      sorters = { "sorter_rank" },
			      converters = { "converter_remove_overlap" },
			      minAutoCompleteLength = 1,
			      minManualCompleteLength = 0,
			      keywordPattern = [[\k+]]
		      },
		      lsp = {
			      mark = "[lsp]",
		      },
		      around = {
			      mark = "[ard]"
		      }
	      },
      })


      -- Denops が ready になるのを待ってから enable する
      vim.api.nvim_create_autocmd("User", {
        pattern = "DenopsReady",
        callback = function()
		vim.fn["ddc#enable"]()
	end
      })

      vim.keymap.set("i", "<C-n>","<Cmd>call pum#map#insert_relative(+1)<CR>", {})
      vim.keymap.set("i", "<C-p>","<Cmd>call pum#map#insert_relative(-1)<CR>", {})
      vim.keymap.set("i", "<C-y>", "<Cmd>call pum#map#confirm()<CR>", {})
      vim.keymap.set("i", "<C-e>", "<Cmd>call pum#map#cancel()<CR>", {})

    end
  }
}
