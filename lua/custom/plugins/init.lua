-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  'tpope/vim-fugitive',
  'andersjanmyr/vim-scratch',
  'axelf4/vim-strip-trailing-whitespace',
  'editorconfig/editorconfig-vim',
  'godlygeek/tabular',
  'fatih/vim-go',
  'hashivim/vim-terraform',
  'jose-elias-alvarez/typescript.nvim',
  'mbbill/undotree',
  'mileszs/ack.vim',
  'phelipetls/vim-jqplay',
  'ruanyl/vim-gh-line',
  'sbdchd/neoformat',
  {
    'tomtom/tcomment_vim',
    config = function()
      vim.keymap.set('n', '<Leader>c', ':TComment<cr>')
      vim.keymap.set('v', '<Leader>c', ':TComment<cr>')
    end,
  },
  'tpope/vim-eunuch',
  'tpope/vim-repeat',
  'tpope/vim-sexp-mappings-for-regular-people',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  {
    'lifepillar/vim-solarized8',
    config = function()
      vim.cmd 'colorscheme solarized8'
      vim.g.solarized_termcolors = 256
    end,
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'olimorris/neotest-phpunit',
    },
    config = function()
      local neotest = require 'neotest'
      vim.keymap.set('n', '<leader>t', ':lua require("neotest").run.run()<cr>', {})
      neotest.setup {
        adapters = {
          require 'neotest-phpunit',
        },
      }
    end,
  },
}
