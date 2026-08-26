# Personal configuration

Everything personal lives in this directory so that `init.lua` stays as close to
upstream kickstart.nvim as possible and `git rebase upstream/master` rarely conflicts.

Rules:

- **Do not edit `lua/kickstart/`** and keep `init.lua` changes to the bare minimum
  (leader, nerd font, parser list, blink keymap, enabling the `require` lines).
  Extend or override plugins from here instead.
- **Files are loaded in filesystem order (unsorted).** Every file must be
  order-independent: only rely on what `init.lua` has already set up, never on
  another file in this directory.
- Prefer extending a plugin's state (`require('lint').linters_by_ft.x = …`,
  a second `conform.setup {}`, `vim.lsp.config()`) over re-running a full setup
  that would discard upstream's configuration.
