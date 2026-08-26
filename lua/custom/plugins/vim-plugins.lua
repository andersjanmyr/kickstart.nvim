-- Assorted (mostly classic vim) plugins that need no or minimal setup
local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'tpope/vim-fugitive',
  gh 'andersjanmyr/vim-scratch',
  gh 'axelf4/vim-strip-trailing-whitespace',
  gh 'godlygeek/tabular',
  gh 'fatih/vim-go',
  gh 'hashivim/vim-terraform',
  gh 'mbbill/undotree',
  gh 'phelipetls/vim-jqplay',
  gh 'ruanyl/vim-gh-line',
  gh 'tpope/vim-eunuch',
  gh 'tpope/vim-repeat',
  gh 'tpope/vim-sexp-mappings-for-regular-people',
  gh 'tpope/vim-unimpaired',
}
