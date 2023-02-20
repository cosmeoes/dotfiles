local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').reset()
require('packer').init({
  compile_path = vim.fn.stdpath('data')..'/site/plugin/packer_compiled.lua',
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'solid' })
    end,
  },
})

local use = require('packer').use

use('wbthomason/packer.nvim')

use({
    'dracula/vim',
    as = 'dracula',
    config = function()
        vim.cmd('colorscheme dracula')

        vim.api.nvim_set_hl(0, 'StatusLineNonText', {
            fg = vim.api.nvim_get_hl_by_name('NonText', true).foreground,
            bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background,
        })

        -- vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#2F313b', })
    end,
})
use('tpope/vim-commentary')
use('tpope/vim-surround')
use('tpope/vim-eunuch')
use('tpope/vim-unimpaired')
use('tpope/vim-sleuth')
use('tpope/vim-repeat')
use('sheerun/vim-polyglot')
use('christoomey/vim-tmux-navigator')
use('farmergreg/vim-lastplace')
use('nelstrom/vim-visual-star-search')
use('jessarcher/vim-heritage')
use({'github/copilot.vim'})
use({
    'whatyouhide/vim-textobj-xmlattr',
    requires = 'kana/vim-textobj-user',
})
use({
    'airblade/vim-rooter',
    setup = function()
        vim.g.rooter_manual_only = 1
    end,
    config = function ()
        vim.cmd('Rooter')
    end,
})
use({
    'windwp/nvim-autopairs',
    config = function()
        require('nvim-autopairs').setup()
    end,
})
use({
    'karb94/neoscroll.nvim',
    config = function()
        require('neoscroll').setup()
    end,
})
use({
    'famiu/bufdelete.nvim',
    config = function()
        vim.keymap.set('n', '<Leader>q', ':Bdelete<CR>')
    end,
})
use({
  'AndrewRadev/splitjoin.vim',
  config = function()
      vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
      vim.g.splitjoin_trailing_comma = 1
      vim.g.splitjoin_php_method_chain_full = 1
  end,
})

use({
  'sickill/vim-pasta',
  config = function()
      vim.g.pasta_disabled_filetypes = { 'fugitive' }
  end,
})

use({
  'nvim-telescope/telescope.nvim',
  requires = {
    { 'nvim-lua/plenary.nvim' },
    { 'kyazdani42/nvim-web-devicons' },
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
  },
  config = function()
    require('user.plugins.telescope')
  end,
})

use({
  'kyazdani42/nvim-tree.lua',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('user.plugins.nvim-tree')
  end,
})

use({
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
        require('user.plugins.lualine')
    end,
})

use({
    'lukas-reineke/indent-blankline.nvim',
    config = function()
        require('user.plugins.indent-blankline')
    end,
})

use({
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
        require('gitsigns').setup({
            sign_priority = 20,
            on_attach = function(bufnr)
                vim.keymap.set('n', ']h', ':Gitsigns next_hunk<CR>')
                vim.keymap.set('n', '[h', ':Gitsigns prev_hunk<CR>')
                vim.keymap.set('n', 'gp', ':Gitsigns preview_hunk<CR>')
                vim.keymap.set('n', 'gb', ':Gitsigns blame_line<CR>')
             end
        })
    end,
})

use({
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    after = 'dracula',
    config = function()
      require('user.plugins.bufferline')
    end,
})

use({
    'tpope/vim-fugitive',
    requires = 'tpope/vim-rhubarb',
    cmd = 'G',
})

use({
    'voldikss/vim-floaterm',
    config = function()
        vim.g.floaterm_width = 0.8
        vim.g.floaterm_height = 0.8
        vim.keymap.set('n', '<F9>', ':FloatermToggle<CR>')
        vim.keymap.set('t', '<F9>', '<C-\\><C-n>:FloatermToggle<CR>')

        vim.cmd([[
            highlight link FloatermBorder CursorLineBg
        ]])
    end,
})

use({
    'glepnir/dashboard-nvim',
    config = function()
        require('user.plugins.dashboard')
    end,
})

use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
        'nvim-treesitter/playground',
        'nvim-treesitter/nvim-treesitter-textobjects',
        'JoosepAlviste/nvim-ts-context-commentstring',
    }, 
    config = function()
        require('user.plugins.treesitter')
    end,
})

use({
  'weilbith/nvim-code-action-menu',
  cmd = 'CodeActionMenu',
})

use({
    'neovim/nvim-lspconfig',
    requires = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
    },
    config = function()
        require('user/plugins/lspconfig')
    end,
})

use({
    'hrsh7th/nvim-cmp',
    requires = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'onsails/lspkind-nvim',
    },
    config = function()
        require('user/plugins/cmp')
    end,
})

use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end
}

use({
  'vim-test/vim-test',
  config = function()
    require('user.plugins.vim-test')
  end,
})

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if packer_bootstrap then
require('packer').sync()
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile>
  augroup end
]])
