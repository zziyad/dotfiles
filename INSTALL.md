# Reinstall notes

No sudo was available. Packages were installed user-locally from Debian trixie `.deb` extracts:

```bash
mkdir -p ~/tmp-pkgs ~/.local
cd ~/tmp-pkgs
apt-get download zsh zsh-common tmux libevent-core-2.1-7t64 libevent-2.1-7t64
dpkg-deb -x zsh_*.deb ~/.local/zsh-root
dpkg-deb -x zsh-common_*.deb ~/.local/zsh-root
dpkg-deb -x tmux_*.deb ~/.local/tmux-root
dpkg-deb -x libevent-core-2.1-7t64_*.deb ~/.local/tmux-root
dpkg-deb -x libevent-2.1-7t64_*.deb ~/.local/tmux-root
ln -sfn ../zsh-root/usr/bin/zsh ~/.local/bin/zsh
# tmux: use a wrapper (not a symlink) so LD_LIBRARY_PATH finds libevent:
#   ~/.local/bin/tmux → exec ~/.local/tmux-root/usr/bin/tmux
```

When sudo is available later, prefer:

```bash
sudo apt install zsh tmux
echo "$HOME/.local/bin/zsh" | sudo tee -a /etc/shells   # or use /usr/bin/zsh
chsh -s $(which zsh)
# then remove the bashrc "zsh default exec" block
```

Restore configs from this repo:

```bash
cp -a .zshrc .tmux.conf ~/
mkdir -p ~/.config
rsync -a .config/nvim/ ~/.config/nvim/
```
