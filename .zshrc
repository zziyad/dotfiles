# ~/.zshrc ? lightweight durable setup (finance@financeServer)
# User-local zsh from ~/.local/zsh-root (no sudo)

# --- PATH first (nvim, rg, fd, zig, zsh, tmux) ? must not be clobbered ---
typeset -U path PATH
path=("$HOME/.local/bin" $path)
export PATH

# uv / other env helpers
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Relocated Debian zsh ? modules FIRST, then fpath, then Tab completion
ZSH_LOCAL="$HOME/.local/zsh-root"
ZSH_MOD="$ZSH_LOCAL/usr/lib/x86_64-linux-gnu/zsh/5.9"
ZSH_FN="$ZSH_LOCAL/usr/share/zsh/functions"
if [ -d "$ZSH_MOD" ]; then
  module_path=("$ZSH_MOD" $module_path)
fi
if [ -d "$ZSH_FN" ]; then
  setopt NULL_GLOB
  fpath=(
    $ZSH_FN/*
    $ZSH_FN/Completion/*
    $fpath
  )
  unsetopt NULL_GLOB
fi

# History
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE EXTENDED_HISTORY

# Tab completion
setopt NULL_GLOB
rm -f ~/.zcompdump ~/.zcompdump.*
unsetopt NULL_GLOB
autoload -Uz compinit && compinit -u
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
bindkey '^I' expand-or-complete


# Keys / quality of life
bindkey -e
setopt AUTO_CD INTERACTIVE_COMMENTS
alias ll='ls -la --color=auto'
alias la='ls -A --color=auto'
alias ls='ls --color=auto'

# nvm (same as bashrc) ? then put ~/.local/bin first again for nvim/rg/fd/zig
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
path=("$HOME/.local/bin" $path)
export PATH


# Prompt: Starship (git branch/status)
eval "$(starship init zsh)"
