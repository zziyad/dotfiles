-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Ensure user-local tools (nvim helpers, zigcc, unzip, fzf, rg, fd) are on PATH
-- even when Neovim is launched from a minimal environment.
do
  local home = vim.fn.expand("~")
  local local_bin = home .. "/.local/bin"
  local mason_bin = home .. "/.local/share/nvim/mason/bin"
  local path = vim.env.PATH or ""
  if not path:find(local_bin, 1, true) then
    vim.env.PATH = local_bin .. ":" .. path
  end
  path = vim.env.PATH or ""
  if not path:find(mason_bin, 1, true) then
    vim.env.PATH = mason_bin .. ":" .. path
  end
end

-- Use zig via wrapper as C compiler for nvim-treesitter / tree-sitter-cli
-- (no system gcc; zig 0.14 rejects LLVM triples like x86_64-unknown-linux-gnu)
vim.env.CC = vim.fn.expand("~/.local/bin/zigcc")
vim.env.CXX = vim.fn.expand("~/.local/bin/zigcc")

-- Dark terminal: skip Neovim's OSC 11 background probe (leaks under tmux+WT).
vim.o.background = "dark"
