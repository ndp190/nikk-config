---
name: fix-nvim-plugin
description: Debug and fix a failing Neovim plugin. Opens a test file in headless nvim, captures errors, consults official docs, and iterates until the plugin loads correctly.
user_invocable: true
---

# Fix Neovim Plugin

Debug and fix a Neovim plugin that fails to build or load.

## Steps

1. **Identify the failing plugin**: Read the plugin spec in `nvim/lua/plugins/` to understand the current configuration.

2. **Capture the actual error**: Run nvim in headless mode to reproduce:
   ```
   nvim --headless -c "edit <test_file>" -c "luafile /tmp/test_plugin.lua" 2>&1
   ```
   Use a lua script with `vim.defer_fn` (3-15s delay) to check if the plugin loaded, inspect errors, and quit.

3. **Consult official documentation**: Use `WebFetch` to read the plugin's README from its GitHub repo (raw.githubusercontent.com). Check for:
   - Current recommended lazy.nvim plugin spec
   - Required dependencies (system packages, npm packages, etc.)
   - Breaking API changes between versions

4. **Fix the config**: Update the plugin spec in `nvim/lua/plugins/`. Common fixes:
   - Remove version pins that lock to old broken versions
   - Update dependencies that changed (e.g., luarocks.nvim no longer needed)
   - Fix API changes (e.g., nvim-treesitter dropped `configs` module and `highlight.enable`)
   - Install missing system dependencies (tree-sitter-cli, luarocks, etc.)

5. **Update chezmoi configurations**: Any fix must be portable across machines.
   - If a new system dependency is needed (brew, npm, pip), add it to `dotfiles/run_once_install-packages.sh.tmpl`
   - Also update the standalone install scripts (`install-brew.sh`, `install-node.sh`, `install-pip.sh`) to keep them in sync
   - If nvim config files changed, they are already managed via the symlink in `dotfiles/dot_config/symlink_nvim.tmpl`
   - If `lazy.lua` or plugin specs changed, verify the chezmoi-managed nvim config points to the right files

6. **Clean stale build artifacts**: Remove cached builds that may interfere:
   ```
   rm -rf ~/.local/share/nvim/lazy-rocks/<plugin-name>
   ```

7. **Test in headless mode**: Re-run the headless test to verify the fix. Iterate until:
   - The plugin loads without errors (`require("<plugin>")` succeeds)
   - Plugin commands are available
   - Features work (syntax highlighting, keymaps, etc.)

8. **Verify related functionality**: If the plugin depends on treesitter, check:
   - Parser is installed (`TSInstall <lang>`)
   - Highlighting is active (`vim.treesitter.highlighter.active[bufnr]`)
   - Query files exist (`queries/<lang>/highlights.scm`)

9. **Post-fix cleanup**: Remove any bloat introduced during debugging:
   - Remove brew/npm/pip packages installed during troubleshooting that turned out unnecessary (e.g., `brew uninstall tree-sitter` if only `tree-sitter-cli` via npm was needed)
   - Remove commented-out old plugin specs that are no longer relevant — don't leave dead code
   - Remove standalone plugin entries that were only needed by the old config (e.g., `luarocks.nvim` if rest.nvim no longer needs it)
   - Clean up any temporary test files created during debugging (`/tmp/test_*.lua`)
   - Verify `lazy-lock.json` doesn't reference removed plugins
   - Run `nvim --headless -c "Lazy clean" -c "qa!"` to remove orphaned plugin directories

## Key debugging patterns

```lua
-- Test plugin loading (save as /tmp/test_plugin.lua)
vim.defer_fn(function()
  local ok, err = pcall(require, "<plugin-module>")
  print("loaded: " .. tostring(ok))
  if not ok then print("Error: " .. tostring(err)) end

  -- Check for commands
  local cmds = vim.api.nvim_get_commands({})
  for name, _ in pairs(cmds) do
    if name:match("<CommandPrefix>") then
      print("Found: " .. name)
    end
  end

  -- Check treesitter highlighting
  local hl = vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()]
  print("highlight active: " .. tostring(hl ~= nil))

  vim.cmd("qa!")
end, 5000)
```

## Important notes

- Always read current plugin source/README before making changes — APIs change between versions
- New nvim-treesitter (2024+) removed `nvim-treesitter.configs` module; use `vim.treesitter.start()` per filetype instead
- lazy.nvim rocks with `hererocks = true` can have module path issues; `hererocks = false` with system luarocks may work better
- When cleaning artifacts, also check `~/.local/share/nvim/lazy/<plugin>/` and `~/.local/share/nvim/site/parser/`
