# Upstream updates

Source: https://github.com/nvim-lua/kickstart.nvim

Reviewed through `8e35dbedb7966e3a95e1f26f9fc1179ab6c68db4` (`master`).
This is a selective port, not a merge of upstream history.

## Approach

A direct merge would reintroduce the single-file configuration and migrate to
`vim.pack`. Following upstream's `lazy` branch would retain Lazy.nvim but miss
newer fixes. Instead, adapt applicable changes from `master` into the existing
modules, retaining Lazy.nvim and `lazy-lock.json`.

Runtime inspection before the port found that the Treesitter spec passed legacy
options to the rewritten plugin: no parser installation or attachment autocmd was
registered, and Lua used `GetLuaIndent()` rather than Treesitter indentation.
The LSP spec also forced a nightly Rust build of Blink despite using its Lua matcher.

## Port scope

- Use Treesitter's current install/attach API, including buffer validity checks,
  filetype-to-language mapping, parser auto-installation, and query-based indentation.
- Remove Blink's redundant LSP dependency and Rust build command.
- Keep Telescope LSP picker mappings with Telescope, add command search, and follow
  symlinks when searching the configuration.
- Avoid mini.ai conflicts with Neovim 0.12 incremental selection (`aa` / `ii`).
- Adopt diagnostic warning underlines and diagnostic-jump floats.
- Run formatting CI for this fork using upstream's ordinary push/PR events.

Keep Kanagawa Dragon, Lazydev, completion sources, existing format-on-save policy,
external StyLua formatting, Mason server configuration, and nvim-web-devicons.
The recommended Gitsigns mappings and which-key groups were already present.
Do not add unused optional plugin examples or upstream's `vim.pack` loader.

## Validation

Run StyLua across the repository and start the real configuration. Open Lua and
another supported language, check parser attachment and indentation, wait for
Lua LSP attachment, exercise Telescope and buffer-local Gitsigns mappings, and
check that startup produces no errors. Compare before/after terminal captures.

Verified with Neovim 0.12.6 and installed plugin commits matching `lazy-lock.json`:

- Lua LSP, Treesitter highlighting, and Treesitter indentation attach.
- Python's parser auto-installs when opening a Python file, then attaches.
- LSP picker and Gitsigns mappings stay buffer-local.
- Saving Lua formats it through Conform and StyLua.
- Mason installs StyLua, and startup reports no Neovim errors.
- `<space>sc` opens the command picker in the terminal UI.
- `stylua --check .` and `git diff --check` pass.

Treesitter parser installation requires a C compiler and `tree-sitter` CLI.
Mason's StyLua installer also needs `unzip`. Missing `tree-sitter`, StyLua, and
`unzip` executables were installed in `~/.local/bin` on this machine without sudo.
Terminal captures are in `/tmp/nvim-before.txt`, `/tmp/nvim-final.txt`, and
`/tmp/nvim-telescope.txt` (temporary session evidence, not repository fixtures).

## Future updates

```sh
git fetch upstream
# Compare against the reviewed revision above, then adapt changed sections.
git diff 8e35dbedb7966e3a95e1f26f9fc1179ab6c68db4 upstream/master -- init.lua lua .github
```

Update the reviewed revision and scope after validating each port. Do not use an
`ours` merge to mark unported upstream changes as integrated.
