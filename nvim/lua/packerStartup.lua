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

  -- for parser and lexing in Haskell
  use 'andy-morris/happy.vim'
  use 'andy-morris/alex.vim'


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
