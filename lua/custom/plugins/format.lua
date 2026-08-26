-- Formatting: extend kickstart's conform setup (conform.setup merges with the previous call)
require('conform').setup {
  format_on_save = function(bufnr)
    -- Disable "format_on_save lsp_fallback" for languages that don't
    -- have a well standardized coding style.
    local disable_filetypes = { c = true, cpp = true, erlang = true }
    local ft = vim.bo[bufnr].filetype
    if disable_filetypes[ft] then return nil end
    -- Some formatters (php-cs-fixer) are slow, give them more time
    local slow_filetypes = { php = 5000 }
    return { timeout_ms = slow_filetypes[ft] or 500, lsp_format = 'fallback' }
  end,
  formatters = {
    php_cs_fixer = {
      inherit = true,
      cwd = function(_, ctx)
        return require('conform.util').root_file {
          '.php-cs-fixer.php',
          '.php-cs-fixer.dist.php',
          'composer.json',
        }(nil, ctx)
      end,
    },
  },
  formatters_by_ft = {
    lua = { 'stylua' },
    sh = { 'shfmt' },
    bash = { 'shfmt' },
    terraform = { 'terraform_fmt' },
    python = { 'ruff_organize_imports', 'ruff_format' },
    php = { 'php_cs_fixer' },
    javascript = { 'oxfmt' },
    javascriptreact = { 'oxfmt' },
    typescript = { 'oxfmt' },
    typescriptreact = { 'oxfmt' },
    vue = { 'oxfmt' },
    json = { 'oxfmt' },
    jsonc = { 'oxfmt' },
    yaml = { 'oxfmt' },
    html = { 'oxfmt' },
    css = { 'oxfmt' },
    scss = { 'oxfmt' },
    markdown = { 'oxfmt' },
    sql = { 'sqlfmt' },
  },
}

-- <leader>f is taken by Telescope git_files (options.lua), so format lives on <leader>F
vim.keymap.set({ 'n', 'v' }, '<leader>F', function() require('conform').format { async = true, lsp_format = 'fallback' } end, { desc = '[F]ormat buffer' })
