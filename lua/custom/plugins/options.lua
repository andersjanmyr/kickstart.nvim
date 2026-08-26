-- Personal options, keymaps and autocommands.
-- (mapleader and have_nerd_font are set in init.lua since they must come first.)

-- Use a dedicated virtualenv for the Python provider
vim.g.python3_host_prog = vim.fn.expand '~/.pyenv/versions/neovim3/bin/python'

-- [[ Keymaps ]]
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('i', ':w', '<Esc>:w<cr>')
vim.keymap.set('n', '/', '/\\v')
vim.keymap.set('v', '/', '/\\v')
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('v', '>', '>gv', { desc = 'Indent and re-select' })
vim.keymap.set('v', '<', '<gv', { desc = 'Dedent and re-select' })
vim.keymap.set('n', '<Leader>e', ":e <C-R>=expand('%:p:h') . '/' <cr>")
vim.keymap.set('c', '%%', "<C-R>=expand('%:h').'/'<cr>")
vim.keymap.set('n', '<leader>gg', ':Ggrep <C-R><C-W>')
vim.keymap.set('n', '<leader>u', ':UndotreeToggle<cr>')
-- Comment toggling via the builtin `gc` operator
vim.keymap.set('n', '<Leader>c', 'gcc', { remap = true, desc = 'Toggle [C]omment' })
vim.keymap.set('v', '<Leader>c', 'gc', { remap = true, desc = 'Toggle [C]omment' })

-- Telescope: <leader>f is git files (format is on <leader>F, see format.lua)
local builtin = require 'telescope.builtin'
pcall(vim.keymap.del, { 'n', 'v' }, '<leader>f')
vim.keymap.set('n', '<leader>f', builtin.git_files, { desc = 'Git [F]ind files' })
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Find existing [B]uffers' })

-- Keep classic gd for go-to-definition
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('custom-lsp-attach', { clear = true }),
  callback = function(event) vim.keymap.set('n', 'gd', builtin.lsp_definitions, { buffer = event.buf, desc = '[G]oto [D]efinition' }) end,
})

-- which-key groups for the personal prefixes
require('which-key').add {
  { '<leader>T', group = '[T]est' },
  { '<leader>d', group = '[D]ebug' },
  { '<leader>x', group = 'Trouble / Diagnostics' },
}

-- [[ Autocommands ]]
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'elixir' },
  command = 'setlocal expandtab ts=2 sts=2 sw=2',
})
