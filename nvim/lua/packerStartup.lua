return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Lsp config
  use 'neovim/nvim-lspconfig'

  -- Coq
  use 'whonore/Coqtail'

  -- Haskell highlight
  use 'neovimhaskell/haskell-vim'

  -- Haskell hoogle
  use 'junegunn/fzf'

  use 'monkoose/fzf-hoogle.vim'

  -- Idris
  use {
    'ShinKage/idris2-nvim',
    requires = { 'neovim/nvim-lspconfig', 'MunifTanjim/nui.nvim' }
  }

  use {
    "edwinb/idris2-vim"
  }

  -- file tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require 'nvim-tree'.setup {} end
  }

  -- window travel with ease
  use 'https://gitlab.com/yorickpeterse/nvim-window.git'

  -- autocompletion and snippets
  use {
    'hrsh7th/nvim-cmp'
    , requires = {
    { 'neovim/nvim-lspconfig' }
    , { 'hrsh7th/cmp-nvim-lsp' }
  , { 'hrsh7th/cmp-buffer' }
  , { 'hrsh7th/cmp-path' }
  , { 'hrsh7th/cmp-cmdline' }
  , { 'L3MON4D3/LuaSnip' }
  , { 'saadparwaiz1/cmp_luasnip' }
  },
    -- commit = "777450fd0ae289463a14481673e26246b5e38bf2"
  }
  use "rafamadriz/friendly-snippets"

  --  use { 'ms-jpq/coq_nvim', branch = 'coq' }
  --  use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }

  -- Latex
  use 'KeitaNakamura/tex-conceal.vim'

  -- PureScript
  use 'purescript-contrib/purescript-vim'

  -- Nix
  use 'LnL7/vim-nix'

  -- Markdown
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  -- Show indentation lines
  use "lukas-reineke/indent-blankline.nvim"

  -- finally added fugitive
  use "tpope/vim-fugitive"

  -- python Lark files
  -- use 'chanicpanic/vim-lark-syntax'

  -- for parser and lexing in Haskell
  use 'andy-morris/happy.vim'
  use 'andy-morris/alex.vim'

  -- Aiken
  -- use 'aiken-lang/editor-integration-nvim'

  -- SyntaxRange
  use 'vim-scripts/SyntaxRange'

  -- Finally got convinced to try treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  use "qnighy/lalrpop.vim"

  -- Local pluging to add file type for the language I'm working on
  use {
    '~/projects/vim-octizys'
  }

  -- Local pluging to add file type for koka
  use {
    '~/projects/vim-koka'
  }

  use {
    "folke/tokyonight.nvim"
  }

  use {
    "nvim-treesitter/nvim-treesitter-refactor"
  }

  use {
    "jhofscheier/ltex-utils.nvim"
  }
  use {
    "liangxianzhe/floating-input.nvim"
  }
end)
