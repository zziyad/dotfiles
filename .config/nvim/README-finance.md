# LazyVim on finance@financeServer

Installed from [LazyVim/starter](https://github.com/LazyVim/starter) (devaslife-style LazyVim setup).

## Versions (as of install)

- NVIM v0.12.5
- ripgrep ripgrep 15.2.0 (rev e89fff89ac)
- fd fd 10.5.0
- git git version 2.47.3
- zig 0.14.1 (user-local C compiler for Treesitter; no system gcc)

## Binaries (user-local — no sudo, no Docker / monorepo impact)

| Tool | Path |
|------|------|
| Neovim | `~/.local/bin/nvim` → `~/.local/share/nvim-linux-x86_64/` |
| ripgrep | `~/.local/bin/rg` |
| fd | `~/.local/bin/fd` |
| zig | `~/.local/bin/zig` |
| Config | `~/.config/nvim` (starter; `.git` removed) |
| Plugins | `~/.local/share/nvim/lazy` |
| Docs | `~/.config/nvim/README-finance.md` (this file) |

`PATH` already includes `~/.local/bin` via `~/.profile` / `~/.bashrc`.

**Safety:** only `~/.config/nvim`, `~/.local/{bin,share,state}` were touched. `~/monorepo*`, `~/metarhia-lab`, Docker images/containers unchanged.

## How to open

```bash
ssh finance@100.92.131.118
nvim                          # dashboard
nvim path/to/file
nvim .
cd ~/monorepo && nvim .
```

## Essential keys (leader = Space)

| Keys | Action |
|------|--------|
| `Space` `e` | File tree (Neo-tree) |
| `Space` `Space` | Find file |
| `Space` `/` | Live grep (ripgrep) |
| `Shift` `h` / `Shift` `l` | Prev / next buffer (tabs at top) |
| `Space` `b` `d` | Close buffer |
| `Space` `q` `q` | Quit |
| `:Lazy` | Plugin manager |
| `:LazyExtras` | More extras |
| `:Mason` | LSP / formatters |

## Enabled extras (web + Python)

Imported in `lua/config/lazy.lua`:

- `lang.typescript`
- `lang.json`
- `lang.markdown`
- `lang.python`

First interactive open may download LSPs via Mason (needs network).

```bash
nvim --headless "+Lazy! sync" +qa
```

## Nerd Font (icons over SSH)

Fonts are rendered by **your local terminal**, not the remote server. You cannot install a font “for user finance” on the SSH host and have it appear in your client.

1. Install a Nerd Font on your laptop (e.g. JetBrainsMono Nerd Font / MesloLGS NF from https://www.nerdfonts.com/).
2. Set your SSH terminal (iTerm2, Windows Terminal, Kitty, Alacritty, …) to that font.
3. Reconnect. Without a Nerd Font the editor still works; some icons may show as boxes.

## Treesitter note

No system `gcc` (no passwordless sudo). User-local **zig** is installed and `vim.env.CC = "zig cc"` is set in `lua/config/options.lua` so parsers can compile.

## Fix notes (2026-09-28)

What was broken:
1. **Treesitter compile** — `zig 0.14` rejected LLVM triples (`x86_64-unknown-linux-gnu`). Fixed with `~/.local/bin/zigcc` wrapper + `CC`/`CXX` in `lua/config/options.lua`.
2. **Mason stylua** — system `unzip` missing. Linked BusyBox unzip to `~/.local/bin/unzip`.
3. **PATH** — `~/.local/bin` now set early in `.bashrc` (before interactive guard) and injected by `options.lua` inside Neovim. Also installed user-local `fzf`.
4. **"loaded 4/38"** — normal LazyVim lazy-loading at startup (not a failure). After UI opens, more plugins load on demand.

Open:
```bash
ssh finance@100.92.131.118
nvim
# or: nvim .
# Space e = tree, Space Space = files, Space / = grep
```
