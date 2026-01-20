# Modular Neovim Configuration

This is a modularized Neovim configuration based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

## Structure

The configuration is split into two main directories for better maintainability:

- `lua/config/`: Contains core Neovim settings (options, keymaps, autocommands).
- `lua/plugins/`: Contains individual plugin specifications and configurations (managed by `lazy.nvim`).

### Directory Layout

```text
.
├── init.lua              # Entry point (bootstraps lazy.nvim)
├── lazy-lock.json        # Plugin lockfile
├── lua
│   ├── config
│   │   ├── autocmds.lua  # Auto-commands (e.g., highlight on yank)
│   │   ├── keymaps.lua   # Global key mappings
│   │   └── options.lua   # General vim options (line numbers, etc.)
│   └── plugins
│       ├── blink.lua     # Autocompletion
│       ├── conform.lua   # Auto-formatting
│       ├── lsp.lua       # LSP & Mason configuration
│       ├── telescope.lua # Fuzzy finder configuration
│       ├── treesitter.lua# Syntax highlighting
│       ├── ui.lua        # UI plugins (colorscheme, mini.nvim)
│       └── ...           # Other plugins
```

## Installation

1. **Backup** your existing configuration:
   ```sh
   mv ~/.config/nvim ~/.config/nvim.bak
   mv ~/.local/share/nvim ~/.local/share/nvim.bak
   ```

2. **Clone** this repository:
   ```sh
   git clone https://github.com/JuanJoseGonGi/nvim.git ~/.config/nvim
   ```

3. **Start Neovim**:
   ```sh
   nvim
   ```
   Lazy.nvim will automatically install and configure all plugins on the first run.
