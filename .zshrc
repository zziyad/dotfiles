# ~/.zshrc — lightweight durable setup (finance@financeServer)
# User-local zsh from ~/.local/zsh-root (no sudo)

# --- PATH first (nvim, rg, fd, zig, zsh, tmux) — must not be clobbered ---
typeset -U path PATH
path=("$HOME/.local/bin" $path)
export PATH

# uv / other env helpers
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Relocated Debian zsh functions + modules (user-local extract)
ZSH_LOCAL="$HOME/.local/zsh-root"
if [ -d "$ZSH_LOCAL/usr/share/zsh/functions" ]; then
  fpath=(
    "$ZSH_LOCAL/usr/share/zsh/functions"/*(/N)
    "$ZSH_LOCAL/usr/share/zsh/5.9/functions"(N)
    /usr/share/zsh/site-functions(N)
    /usr/share/zsh/vendor-completions(N)
    $fpath
  )
fi
if [ -d "$ZSH_LOCAL/usr/lib/x86_64-linux-gnu/zsh/5.9" ]; then
  module_path=("$ZSH_LOCAL/usr/lib/x86_64-linux-gnu/zsh/5.9" $module_path)
fi

# History
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE EXTENDED_HISTORY

# Completion (optional soft fail if modules missing)
autoload -Uz compinit 2>/dev/null && compinit -u 2>/dev/null || true

# Prompt simple
autoload -Uz colors && colors
PROMPT='%F{green}%n@%m%f:%F{blue}%~%f%(!.#.$) '
RPROMPT=''

# Keys / quality of life
bindkey -e
setopt AUTO_CD INTERACTIVE_COMMENTS
alias ll='ls -la --color=auto'
alias la='ls -A --color=auto'
alias ls='ls --color=auto'

# nvm (same as bashrc) — then put ~/.local/bin first again for nvim/rg/fd/zig
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
path=("$HOME/.local/bin" $path)
export PATH

# Optional: uncomment to add oh-my-zsh later (keep PATH block above OMZ)
# export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="robbyrussell"
# plugins=(git)
# source $ZSH/oh-my-zsh.sh
