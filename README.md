# finance@financeServer dotfiles

Snapshot of shell / tmux / Neovim (LazyVim) config for the `finance` user.
**You create the GitHub repo and push yourself** — this folder is prepared only.

## What is installed on the server (already done)

| Item | Location / notes |
|------|------------------|
| zsh 5.9 | user-local: `~/.local/bin/zsh` → `~/.local/zsh-root/` (apt debs extracted; no sudo) |
| tmux 3.5a | user-local: `~/.local/bin/tmux` (wrapper + `~/.local/tmux-root/` + libevent) |
| Default shell | `/etc/passwd` still `/bin/bash` (chsh blocked: no password, zsh not in `/etc/shells`). Interactive SSH → bash → `exec zsh -l` via `~/.bashrc` marker. |
| tmux panes | `~/.tmux.conf` sets `default-shell` / `default-command` to `~/.local/bin/zsh` |
| git | `user.name=zziyad` `user.email=zziyad@users.noreply.github.com` |
| nvim PATH | `~/.local/bin` kept first in bash + zsh |
| Docker / monorepo | untouched |

## Files in this repo (commit these)

```
.zshrc
.tmux.conf
.config/nvim/          # LazyVim tree (snapshot of ~/.config/nvim)
README.md
INSTALL.md
```

Optional later: add `.gitconfig` if you want identity in-repo (currently only in `~/.gitconfig`).

## Live home ↔ this folder

**Current strategy: copy/snapshot** (home remains source of truth on the server).

```bash
# Refresh snapshot FROM home INTO ~/dotfiles (before commit)
cp -a ~/.zshrc ~/dotfiles/.zshrc
cp -a ~/.tmux.conf ~/dotfiles/.tmux.conf
rsync -a --delete --exclude='.git' ~/.config/nvim/ ~/dotfiles/.config/nvim/
```

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

## Create GitHub repo and push (you run these)

```bash
cd ~/dotfiles
git init
git add .zshrc .tmux.conf .config/nvim README.md INSTALL.md
git status   # review; avoid committing secrets
git commit -m "Initial financeServer dotfiles: zsh, tmux, LazyVim"
# create empty repo on GitHub (web UI or gh), then:
git branch -M main
git remote add origin git@github.com:zziyad/DOTFILES_REPO_NAME.git
# or: https://github.com/zziyad/DOTFILES_REPO_NAME.git
git push -u origin main
```

Replace `DOTFILES_REPO_NAME` with whatever you create (e.g. `financeserver-dotfiles`).

## Quick usage

```bash
ssh finance@100.92.131.118   # lands in zsh via bashrc exec
tmux new -s main             # new session (zsh panes)
tmux attach -t main          # reattach
NO_ZSH_EXEC=1 bash           # stay in bash if needed
```
