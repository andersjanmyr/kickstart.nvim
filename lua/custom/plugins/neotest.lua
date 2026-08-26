-- Test runner with adapters for phpunit, pytest, jest and vitest
-- (plenary and nvim-treesitter are already added in init.lua)
local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'nvim-neotest/nvim-nio',
  gh 'antoinemadec/FixCursorHold.nvim',
  gh 'nvim-neotest/neotest',
  gh 'olimorris/neotest-phpunit',
  gh 'nvim-neotest/neotest-python',
  gh 'nvim-neotest/neotest-jest',
  gh 'marilari88/neotest-vitest',
}

local neotest = require 'neotest'

vim.keymap.set('n', '<leader>Tt', function() neotest.run.run() end, { desc = '[T]est: nearest' })
vim.keymap.set('n', '<leader>Tf', function() neotest.run.run(vim.fn.expand '%') end, { desc = '[T]est: file' })
vim.keymap.set('n', '<leader>Ta', function() neotest.run.run(vim.uv.cwd()) end, { desc = '[T]est: all' })
vim.keymap.set('n', '<leader>Tl', function() neotest.run.run_last() end, { desc = '[T]est: last' })
vim.keymap.set('n', '<leader>Ts', function() neotest.summary.toggle() end, { desc = '[T]est: summary' })
vim.keymap.set('n', '<leader>To', function() neotest.output.open { enter = true } end, { desc = '[T]est: output' })
vim.keymap.set('n', '<leader>Tp', function() neotest.output_panel.toggle() end, { desc = '[T]est: output panel' })
vim.keymap.set('n', '<leader>Tx', function() neotest.run.stop() end, { desc = '[T]est: stop' })

neotest.setup {
  adapters = {
    require 'neotest-phpunit',
    require 'neotest-python' { runner = 'pytest' },
    require 'neotest-jest' { jestCommand = 'npx jest --' },
    require 'neotest-vitest',
  },
}
