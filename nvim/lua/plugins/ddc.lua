return {
  {
    "Shougo/ddc.vim",
    lazy = false,
    dependencies = {
      { "vim-denops/denops.vim", lazy = false },
      { "Shougo/ddc-ui-pum", lazy = false },
      { "Shougo/ddc-source-nvim-lsp", lazy = false },
      { "Shougo/ddc-source-around", lazy = false },
      { "Shougo/ddc-filter-matcher_head", lazy = false },
      { "Shougo/ddc-filter-sorter_rank", lazy = false },
      { "Shougo/ddc-filter-converter_remove_overlap", lazy = false },
      { "Shougo/pum.vim", lazy = false },
    },
    config = function()
      vim.fn["ddc#custom#patch_global"]({
        ui = "pum",
        sources = { "lsp", "around" },
        sourceOptions = {
          _ = {
            matchers = { "matcher_head" },
            sorters = { "sorter_rank" },
            converters = { "converter_remove_overlap" },
          },
        },
      })

      -- Denops が ready になるのを待ってから enable する
      vim.api.nvim_create_autocmd("User", {
        pattern = "DenopsReady",
        callback = function()
          vim.fn["ddc#enable"]()
        end
      })
    end
  }
}

