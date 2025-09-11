# Brian's Vim Configuration

## Overview
This is a personal Vim/Neovim configuration repository using vim-plug for plugin management. The setup supports both Vim and Neovim with conditional plugin loading and configuration.

## Key Components

### Plugin Management
- Uses vim-plug for plugin management
- Auto-installs vim-plug if not present
- Plugins are installed in `~/.vim/plugged/`
- Conditional plugin loading based on Vim/Neovim detection

### Core Plugins
- **Solarized colorscheme**: Different versions for Vim vs Neovim
- **GitHub Copilot**: Neovim only
- **FZF**: File fuzzy finding with custom key bindings
- **Ack.vim + ripgrep**: Fast text searching (ack.vim plugin with ripgrep backend)
- **Tim Pope plugins**: Essential Vim utilities (fugitive, surround, rails, etc.)
- **JavaScript/JSX**: Syntax highlighting and formatting
- **Ruby development**: Rails, RSpec, and Ruby-specific tools

### Custom Functions
- `RenameFile()`: Intelligent file renaming with Git integration
- `RunSpec()`: RSpec test runner with line-specific execution
- `SendFileToAider()`: Integration with Aider AI coding assistant via tmux
- `UpToEnclosingIndent()`: Navigation helper for indented code

### Key Bindings
- Leader key: `,` (comma)
- `Ctrl-P`: FZF file finder
- `Ctrl-F`: Ripgrep search via ack.vim
- `Ctrl-G`: Ruby method definition search
- `<leader>k`: Send current file to Aider (tmux integration)
- `<leader>r/R`: Run RSpec tests (single line/whole file)

## Development Workflow
- Uses temporary directory `~/.vimtmp` for swap/backup files
- Automatic trailing whitespace removal
- Git commit message formatting (72 char width, spellcheck)
- Ruby debugger statement highlighting
- Performance optimizations for large files

## File Structure
```
~/.vim/
├── vimrc                 # Main configuration file
├── autoload/            # vim-plug and other autoloaded functions
├── plugged/             # Plugin installation directory
└── README.md            # Installation and usage instructions
```

## Editing Guidelines

### When modifying this configuration:
1. **Preserve compatibility**: Maintain Vim/Neovim conditional logic
2. **Follow existing patterns**: Use the established plugin loading and configuration style
3. **Test both editors**: Ensure changes work in both Vim and Neovim
4. **Respect performance**: This config emphasizes speed (e.g., TypeScript syntax disabled)
5. **Maintain key bindings**: Existing muscle memory mappings should be preserved
6. **Use feature detection**: Wrap new features in appropriate version/capability checks

### Plugin modifications:
- Add new plugins to the vim-plug section with appropriate conditionals
- Update README.md if special installation steps are required
- Consider performance impact, especially for large files
- Test with both Ruby and JavaScript development workflows

### Configuration changes:
- Maintain the leader key as comma
- Preserve tmux integration functionality
- Keep FZF and ripgrep as primary search tools
- Maintain Ruby development optimizations
- Respect the `~/.vimtmp` directory structure

### Custom functions:
- Follow the existing naming convention (CamelCase for user functions, <SID> for script-local)
- Maintain error handling patterns
- Consider tmux integration where applicable
- Test with Git repositories and non-Git directories