# Dotfiles


## Files in this repo (commit these)

```
.zshrc
.tmux.conf
.config/nvim/          # LazyVim tree (snapshot of ~/.config/nvim)
README.md
INSTALL.md
```

Optional later: add `.gitconfig` if you want identity in-repo (currently only in `~/.gitconfig`).



**Optional symlink strategy** (only if you want home to follow the repo):

```bash
# backup then link — do this only after the repo is the source of truth
mv ~/.zshrc ~/.zshrc.pre-link
mv ~/.tmux.conf ~/.tmux.conf.pre-link
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
# nvim: either
#   mv ~/.config/nvim ~/.config/nvim.pre-link && ln -s ~/dotfiles/.config/nvim ~/.config/nvim
# or keep ~/.config/nvim live and rsync into the repo before push
```



## Quick usage

```bash
# SSH into the host (Tailscale); lands in zsh via bashrc exec
ssh user@host
tmux new -s main             # new session (zsh panes)
tmux attach -t main          # reattach
NO_ZSH_EXEC=1 bash           # stay in bash if needed
```
