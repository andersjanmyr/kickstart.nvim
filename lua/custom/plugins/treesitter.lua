-- Treesitter extras (textobjects, autotag) and Trouble
local function gh(repo) return 'https://github.com/' .. repo end

-- Textobjects: on the `main` branch keymaps are not created by setup(), define them manually
vim.pack.add { gh 'nvim-treesitter/nvim-treesitter-textobjects' }
require('nvim-treesitter-textobjects').setup {
  select = { lookahead = true },
  move = { set_jumps = true },
}

local ts_select = require 'nvim-treesitter-textobjects.select'
local ts_move = require 'nvim-treesitter-textobjects.move'
local ts_swap = require 'nvim-treesitter-textobjects.swap'

local select_maps = {
  { 'af', '@function.outer', 'Around function' },
  { 'if', '@function.inner', 'Inside function' },
  { 'ac', '@class.outer', 'Around class' },
  { 'ic', '@class.inner', 'Inside class' },
  { 'aa', '@parameter.outer', 'Around parameter' },
  { 'ia', '@parameter.inner', 'Inside parameter' },
  { 'ao', '@conditional.outer', 'Around conditional' },
  { 'io', '@conditional.inner', 'Inside conditional' },
  { 'al', '@loop.outer', 'Around loop' },
  { 'il', '@loop.inner', 'Inside loop' },
}
for _, m in ipairs(select_maps) do
  vim.keymap.set({ 'x', 'o' }, m[1], function() ts_select.select_textobject(m[2], 'textobjects') end, { desc = m[3] })
end

local move_maps = {
  { ']m', 'goto_next_start', '@function.outer', 'Next function start' },
  { ']]', 'goto_next_start', '@class.outer', 'Next class start' },
  { ']a', 'goto_next_start', '@parameter.inner', 'Next parameter' },
  { ']M', 'goto_next_end', '@function.outer', 'Next function end' },
  { '][', 'goto_next_end', '@class.outer', 'Next class end' },
  { '[m', 'goto_previous_start', '@function.outer', 'Prev function start' },
  { '[[', 'goto_previous_start', '@class.outer', 'Prev class start' },
  { '[a', 'goto_previous_start', '@parameter.inner', 'Prev parameter' },
  { '[M', 'goto_previous_end', '@function.outer', 'Prev function end' },
  { '[]', 'goto_previous_end', '@class.outer', 'Prev class end' },
}
for _, m in ipairs(move_maps) do
  vim.keymap.set({ 'n', 'x', 'o' }, m[1], function() ts_move[m[2]](m[3], 'textobjects') end, { desc = m[4] })
end

vim.keymap.set('n', '<leader>na', function() ts_swap.swap_next '@parameter.inner' end, { desc = 'Swap with next parameter' })
vim.keymap.set('n', '<leader>pa', function() ts_swap.swap_previous '@parameter.inner' end, { desc = 'Swap with previous parameter' })

-- Auto close/rename JSX/TSX/HTML/PHP tags
vim.pack.add { gh 'windwp/nvim-ts-autotag' }
require('nvim-ts-autotag').setup {}

-- Sticky header showing the current function/class/method (disabled)
-- vim.pack.add { gh 'nvim-treesitter/nvim-treesitter-context' }
-- require('treesitter-context').setup { max_lines = 3, multiline_threshold = 2, trim_scope = 'outer' }

-- Project-wide diagnostics, quickfix, references
vim.pack.add { gh 'folke/trouble.nvim' }
require('trouble').setup { focus = true }
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = '[X] Diagnostics (workspace)' })
vim.keymap.set('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = '[X] Diagnostics (buffer)' })
vim.keymap.set('n', '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = '[X] Symbols' })
vim.keymap.set('n', '<leader>xl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', { desc = '[X] LSP references/defs' })
vim.keymap.set('n', '<leader>xL', '<cmd>Trouble loclist toggle<cr>', { desc = '[X] Location list' })
vim.keymap.set('n', '<leader>xq', '<cmd>Trouble qflist toggle<cr>', { desc = '[X] Quickfix list' })
