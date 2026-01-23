--- Until https://github.com/lumen-oss/rocks.nvim v3 is released
local Plug = vim.fn["plug#"]

vim.call("plug#begin", vim.fs.joinpath(vim.fn.stdpath("data"), "bundle"))

--- Themes
Plug("matsuuu/pinkmare")
Plug("folke/tokyonight.nvim")
Plug("catppuccin/nvim")

--- Treesitter
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate", ["branch"] = "master" })
Plug("nvim-treesitter/nvim-treesitter-refactor")
Plug("nvim-treesitter/nvim-treesitter-textobjects")
Plug("nvim-treesitter/playground")

--- Viewport
Plug("nanozuki/tabby.nvim")
Plug("anuvyklack/windows.nvim")
Plug("anuvyklack/middleclass")
Plug("anuvyklack/animation.nvim")
Plug("wesQ3/vim-windowswap")
Plug("yorickpeterse/nvim-window")
Plug("mrjones2014/smart-splits.nvim")
Plug("MisanthropicBit/winmove.nvim")

--- Functional
Plug("nvim-neo-tree/neo-tree.nvim")
Plug("karb94/neoscroll.nvim")
Plug("MunifTanjim/nui.nvim")
Plug("folke/noice.nvim")
Plug("axieax/urlview.nvim")
Plug("folke/snacks.nvim")
Plug("echasnovski/mini.nvim")
Plug("rcarriga/nvim-notify")
Plug("gbprod/cutlass.nvim")
Plug("laytan/cloak.nvim")
Plug("romainl/vim-cool")
Plug("tpope/vim-commentary")
Plug("alvan/vim-closetag")
Plug("tpope/vim-surround")
Plug("tpope/vim-fugitive")
Plug("tpope/vim-obsession")
Plug("tpope/vim-dotenv")
Plug("monaqa/dial.nvim")
Plug("folke/flash.nvim")

--- Git
Plug("NeogitOrg/neogit")
Plug("sindrets/diffview.nvim")
Plug("isakbm/gitgraph.nvim")
Plug("lewis6991/gitsigns.nvim")

--- Package Manager
Plug("williamboman/mason.nvim", { tag = "stable" })
Plug("williamboman/mason-lspconfig.nvim", { tag = "stable" })
Plug("WhoIsSethDaniel/mason-tool-installer.nvim")

--- LSP
Plug("folke/trouble.nvim")
Plug("neovim/nvim-lspconfig")
Plug("nvim-lua/lsp-status.nvim")
Plug("ray-x/lsp_signature.nvim")

--- CMP
Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/cmp-cmdline")
Plug("hrsh7th/cmp-emoji")
Plug("hrsh7th/cmp-nvim-lua")
Plug("hrsh7th/cmp-vsnip")
Plug("hrsh7th/vim-vsnip")
Plug("rafamadriz/friendly-snippets")

--- Debugging
Plug("mfussenegger/nvim-dap")
Plug("rcarriga/nvim-dap-ui")
Plug("ofirgall/goto-breakpoints.nvim")
Plug("nvim-neotest/nvim-nio")
Plug("theHamsta/nvim-dap-virtual-text")
Plug("leoluz/nvim-dap-go")
Plug("mfussenegger/nvim-dap-python")

--- Telescope
Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope.nvim")
Plug("nvim-telescope/telescope-ui-select.nvim")
Plug("nvim-telescope/telescope-fzf-native.nvim", { ["do"] = "make" })

--- Styles
Plug("ryanoasis/vim-devicons")
Plug("kyazdani42/nvim-web-devicons")
Plug("nvim-lualine/lualine.nvim")

--- Markdown
Plug("iamcco/markdown-preview.nvim", { ["do"] = "cd app && npx --yes yarn install" })
Plug("MeanderingProgrammer/render-markdown.nvim")
Plug("richardbizik/nvim-toc")
Plug("jghauser/follow-md-links.nvim")

--- Development
Plug("jonsmithers/vim-html-template-literals")
Plug("catgoose/nvim-colorizer.lua")
Plug("mhartington/formatter.nvim")
Plug("mfussenegger/nvim-lint")
Plug("akinsho/toggleterm.nvim")
Plug("jiangmiao/auto-pairs")
Plug("jghauser/mkdir.nvim")
Plug("danymat/neogen")
Plug("filipdutescu/renamer.nvim", { branch = "master" })
Plug("cenk1cenk2/schema-companion.nvim", { commit = "71c9e53b399dc7063381c693b7f06f7144772d45" })
Plug("davidmh/mdx.nvim")
Plug("ray-x/go.nvim")
Plug("kcl-lang/kcl.nvim")

--- Database
Plug("tpope/vim-dadbod")
Plug("kristijanhusak/vim-dadbod-ui")
Plug("kristijanhusak/vim-dadbod-completion")

--- AI
Plug("yetone/avante.nvim", { branch = "main", ["do"] = "make" })

--- Misc
Plug("gennaro-tedesco/nvim-jqx")
Plug("manoelcampos/xml2lua")
Plug("lunarmodules/lua-mimetypes")

vim.call("plug#end")
