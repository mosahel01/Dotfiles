
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

Extras
```bash
sudo pacman -S git ghostty alacritty eza zsh stow discord obs-studio nodejs npm neovim tmux docker docker-compose syncthing gnome-keyring gnome-system-monitor gnome-software hyprpaper hyprlock xdg-desktop-portal-hyprland xdg-desktop-portal-gtk xdg-desktop-portal-wlr hyprpolkitagent hyprsunset rofi waybar dmenu cliphist wl-clipboard aquamarine noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-jetbrains-mono ttf-jetbrains-mono-nerd otf-monaspace otf-monaspace-nerd ttf-monaspace-variable ttf-dejavu ttf-liberation ttf-liberation-mono-nerd ttf-roboto gnu-free-fonts adw-gtk-theme nautilus brightnessctl yazi fzf
```

## 🧹 Uninstall

To remove symlinks:

```bash
stow -D nvim
```

---

