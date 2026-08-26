-- Debug adapters and launch configs on top of kickstart.plugins.debug
local dap = require 'dap'

-- Move breakpoint keys under the <leader>d group (<leader>b is Telescope buffers)
pcall(vim.keymap.del, 'n', '<leader>b')
pcall(vim.keymap.del, 'n', '<leader>B')
vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, { desc = 'Debug: Conditional Breakpoint' })

-- JavaScript / TypeScript (vscode-js-debug via mason's js-debug-adapter)
-- $MASON is exported by mason.setup() in init.lua
local js_debug_path = vim.fn.expand '$MASON/packages/js-debug-adapter/js-debug/src/dapDebugServer.js'
for _, adapter in ipairs { 'pwa-node', 'pwa-chrome', 'node-terminal' } do
  dap.adapters[adapter] = {
    type = 'server',
    host = 'localhost',
    port = '${port}',
    executable = {
      command = 'node',
      args = { js_debug_path, '${port}' },
    },
  }
end
for _, lang in ipairs { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' } do
  dap.configurations[lang] = {
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch file (node)',
      program = '${file}',
      cwd = '${workspaceFolder}',
      sourceMaps = true,
      skipFiles = { '<node_internals>/**' },
    },
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach to process',
      processId = function() return require('dap.utils').pick_process() end,
      cwd = '${workspaceFolder}',
      sourceMaps = true,
    },
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Jest: current file',
      runtimeExecutable = 'node',
      runtimeArgs = { './node_modules/jest/bin/jest.js', '--runInBand', '${file}' },
      rootPath = '${workspaceFolder}',
      cwd = '${workspaceFolder}',
      console = 'integratedTerminal',
      internalConsoleOptions = 'neverOpen',
      sourceMaps = true,
    },
  }
end

-- PHP (Xdebug via mason's php-debug-adapter)
dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { vim.fn.expand '$MASON/packages/php-debug-adapter/extension/out/phpDebug.js' },
}
dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9003,
    pathMappings = {
      -- ['/var/www/html'] = '${workspaceFolder}',
    },
  },
}
