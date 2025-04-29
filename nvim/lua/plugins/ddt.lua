return {
	'Shougo/ddt.vim',
	dependencies = {
		'vim-denops/denops.vim',          -- Denops基盤
		'Shougo/ddt-ui-shell',            -- Shell UI
		'Shougo/ddt-ui-terminal',         -- Terminal UI
	},
	lazy = false, -- 起動時即読み込み
	config = function()
		-- ddtのグローバル設定

		local cache_home = vim.fn.stdpath("cache")
		local  history_file = vim.fn.fnamemodify(cache_home .. "/ddt/shell-history.txt", ":p"):gsub("\\", "/")

		vim.fn['ddt#custom#patch_global']({
			ui = 'shell',
			uiParams = {
				shell = {
					noSaveHistoryCommands = { 'history', 'cd', 'ls', 'dir' },
					prompt = '%',
					promptPattern = '\\w*% \\?',
					historyFile  = history_file,
				},
				terminal = {
					command = { 'powershell' },
					promptPattern = vim.fn.has('win32') == 1 and '\\f\\+>' or '\\w*% \\?',
				},
			},
		})

		-- キーマッピング（Shell用）
		vim.keymap.set('n', '<Space>s', function()
			local winid = vim.fn.win_getid()	
			vim.fn['ddt#start']({
				name = 'shell-' .. winid,
				ui = 'shell',
				cwd = clean_path(cwd),
			})
		end, { desc = 'Start ddt shell' })

		-- キーマッピング（Terminal用）
		vim.keymap.set('n', '<Space>t', function()
			vim.fn['ddt#start']({
				name = function()
					return vim.fn.get(vim.t, 'ddt_ui_terminal_last_name', 'terminal-' .. vim.fn.win_getid())
				end,
				ui = 'terminal',
			})
		end, { desc = 'Start ddt terminal' })

		-- ddt-shell用のバッファローカルマッピング
		vim.api.nvim_create_autocmd('FileType', {
			pattern = 'ddt-shell',
			callback = function()
				local opts = { buffer = true }
				vim.keymap.set('n', '<C-n>', function()
					vim.fn['ddt#ui#do_action']('nextPrompt')
				end, opts)
				vim.keymap.set('n', '<C-p>', function()
					vim.fn['ddt#ui#do_action']('previousPrompt')
				end, opts)
				vim.keymap.set('n', '<C-y>', function()
					vim.fn['ddt#ui#do_action']('pastePrompt')
				end, opts)
				vim.keymap.set('n', '<CR>', function()
					vim.fn['ddt#ui#do_action']('executeLine')
				end, opts)
			end,
		})
	end,
}

