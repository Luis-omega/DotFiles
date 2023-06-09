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
  --, { 'hrsh7th/cmp-cmdline' }
  --
  , { 'L3MON4D3/LuaSnip' }
    --, { 'saadparwaiz1/cmp_luasnip' }
  },
    commit = "777450fd0ae289463a14481673e26246b5e38bf2"
  }

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
  use 'chanicpanic/vim-lark-syntax'
end)
