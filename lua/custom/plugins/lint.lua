-- Extra linters on top of kickstart.plugins.lint
local lint = require 'lint'
for ft, linters in pairs {
  javascript = { 'oxlint' },
  javascriptreact = { 'oxlint' },
  typescript = { 'oxlint' },
  typescriptreact = { 'oxlint' },
  python = { 'ruff' },
} do
  lint.linters_by_ft[ft] = linters
end
