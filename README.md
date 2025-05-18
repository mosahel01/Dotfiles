
---

# dotfiles

Minimal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## 📂 Setup

Clone into `~/personal/dotfiles`:

```bash
mkdir -p ~/personal
git clone https://github.com/mosahel01/dotfiles ~/personal/dotfiles
cd ~/personal/dotfiles
```

Symlink configs using `stow`:

```bash
./stow-all.sh

# stow zsh
# stow nvim
# stow zsh
# stow tmux
# stow ghostty
# stow hypr
# stow waybar
# stow keepassxc
# stow bin
```

Each directory corresponds to a set of configs (e.g. `nvim`, `zsh`, etc.).

## 🧹 Uninstall

To remove symlinks:

```bash
stow -D nvim
```

---

