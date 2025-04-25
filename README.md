# Neovim 手動構築環境メモ

## 🧱 前提環境

* Neovim バージョン：v0.11.0

* ターミナル：Windows Terminal

ユーザープロファイルフォルダを極力使用せず、環境変数により各種ディレクトリを指定します。

### ✅ 設定する環境変数（PowerShell 例）

```powershell
$env:XDG_CONFIG_HOME = "C:\var\nvim-config"
$env:XDG_DATA_HOME   = "C:\var\nvim-data"
$env:XDG_CACHE_HOME  = "C:\var\nvim-cache"
$env:XDG_STATE_HOME = "C:\var\nvim-state"
```


### 📁 フォルダ構成（例）

```
C:\var
├── nvim-config\
│   └── nvim\
│       ├── init.lua
│       └── lua\
│           └── plugins\
│               └── lsp.lua
│           └── ...他の設定ファイル
│       └── lazy\
│           └── lazy.nvim （GitHubからzipでダウンロード展開）
│
├── nvim-data\
│   └── lazy\
│       ├── nvim-lspconfig\
│       └── ...他のプラグイン
│
└── nvim-cache\ （キャッシュ用。自動生成される）
```



