-- Solarized instead of the default tokyonight (this runs after init.lua, so it wins)
vim.pack.add { 'https://github.com/lifepillar/vim-solarized8' }
vim.g.solarized_termcolors = 256
vim.cmd.colorscheme 'solarized8'
