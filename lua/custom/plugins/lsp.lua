-- Additional language servers and mason tools on top of the kickstart defaults
local servers = {
  phpactor = {
    cmd = { 'phpactor', 'language-server' },
    filetypes = { 'php' },
    root_markers = { '.phpactor.yml', 'composer.json', '.git' },
    settings = {
      phpactor = {
        language_server_phpstan = { enabled = true },
      },
    },
  },
  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = 'basic',
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = 'openFilesOnly',
        },
      },
    },
  },
  vtsls = {
    settings = {
      typescript = {
        updateImportsOnFileMove = { enabled = 'always' },
        suggest = { completeFunctionCalls = true },
        inlayHints = {
          parameterNames = { enabled = 'literals' },
          parameterTypes = { enabled = true },
          variableTypes = { enabled = false },
          propertyDeclarationTypes = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          enumMemberValues = { enabled = true },
        },
      },
      javascript = {
        updateImportsOnFileMove = { enabled = 'always' },
        suggest = { completeFunctionCalls = true },
      },
    },
  },
  -- erlang_ls is installed by mason as 'erlang-ls' but the lspconfig name differs
  erlangls = {
    cmd = { 'erlang_ls' },
    filetypes = { 'erlang' },
    root_markers = { 'rebar.config', 'erlang.mk', 'rebar.lock', '.git' },
  },
}

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end

-- mason-tool-installer.setup() replaces the ensure_installed list, so this must also
-- contain the tools kickstart's init.lua asks for (stylua, lua_ls).
require('mason-tool-installer').setup {
  ensure_installed = {
    -- from kickstart init.lua
    'stylua',
    'lua_ls',
    -- language servers
    'phpactor',
    'pyright',
    'vtsls',
    'erlang-ls',
    -- formatters / linters
    'oxfmt',
    'php-cs-fixer',
    'shfmt',
    'oxlint',
    'markdownlint',
    'ruff',
    -- debug adapters
    'js-debug-adapter',
    'php-debug-adapter',
    'debugpy',
  },
}
