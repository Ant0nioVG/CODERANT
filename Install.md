# Installation

## Official Packages

```bash
sudo pacman -S hyprland hypridle hyprlock hyprshot swaync kitty thunar quickshell matugen awww uwsm \
  qt6-base qt6-declarative qt6-wayland qt6-svg wireplumber upower brightnessctl playerctl \
  cliphist polkit-gnome wofi nemo pulsemixer btop imagemagick noto-fonts ttf-jetbrains-mono-nerd \
  ttf-cascadia-code-nerd kvantum zsh zsh-syntax-highlighting zsh-autosuggestions yazi base-devel git \
  neovim wl-clipboard wget lsd fastfetch bat
```

## AUR Packages

```bash
paru -S skwd-daemon-bin skwd-wall wlctl-bin zen-browser-bin
systemctl --user enable --now skwd-daemon.service
```

## Setup

### 1. Clone the repository

```bash
git clone --depth 1 https://github.com/Ant0nioVG/CODERANT.git ~/CODERANT
```

### 2. Backup existing configs and install

Backup your current configs and copy the new ones:

```bash
# Backup existing configs
[ -e ~/.config/hypr ]         && mv ~/.config/hypr         ~/.config/hypr.bak
[ -e ~/.config/kitty ]        && mv ~/.config/kitty        ~/.config/kitty.bak
[ -e ~/.config/nvim ]         && mv ~/.config/nvim         ~/.config/nvim.bak
[ -e ~/.config/quickshell ]   && mv ~/.config/quickshell   ~/.config/quickshell.bak
[ -e ~/.config/swaync ]       && mv ~/.config/swaync       ~/.config/swaync.bak
[ -e ~/.config/wofi ]         && mv ~/.config/wofi         ~/.config/wofi.bak
[ -e ~/.config/yazi ]         && mv ~/.config/yazi         ~/.config/yazi.bak
[ -e ~/.config/skwd-wall ]    && mv ~/.config/skwd-wall    ~/.config/skwd-wall.bak
[ -e ~/.config/btop ]         && mv ~/.config/btop         ~/.config/btop.bak
[ -e ~/.config/fastfetch ]    && mv ~/.config/fastfetch    ~/.config/fastfetch.bak
[ -f ~/.zshrc ]               && mv ~/.zshrc               ~/.zshrc.bak

# Install LazyVim starter (base framework for the nvim config)
git clone --depth 1 https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# Overlay custom config on top of the starter
cp -r ~/CODERANT/Config/nvim/* ~/.config/nvim/

# Copy the rest of the configs (nvim handled above)
for d in ~/CODERANT/Config/*; do
  [ "$(basename "$d")" = "nvim" ] && continue
  [ "$(basename "$d")" = "zen" ] && continue
  cp -r "$d" ~/.config/
done

cp ~/CODERANT/Home/.zshrc ~/.zshrc
mkdir -p ~/Wallpapers

# Install plugins on first launch
nvim
```

### 3. Update username in wofi config

Wofi does not support `~` for paths, so the config uses an absolute path. After copying the configs, edit `~/.config/wofi/config` and replace `your-user` with your actual username:

```bash
sed -i "s/your-user/$USER/g" ~/.config/wofi/config
```

### 4. ZSH Configuration

```bash
chsh -s $(which zsh)
git clone --depth 1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
zsh
p10k configure
```

### 5. Create Tasks directory

```bash
mkdir -p ~/Tasks
```

### 6. Zen Browser — Import Mods

This repo includes a pre-configured Zen Browser mods export (`Config/zen/zen-mods-export.json`) with these mods:

- **Transparent Zen** — Transparent tab background and smooth animations
- **No Top Sites** — Hides top sites when opening the URL bar
- **Better Unloaded Tabs** — Greyscale and dim unloaded tabs

To apply them:

1. Open **Zen Browser**
2. Go to **Settings** (or `about:preferences`)
3. Navigate to the **Zen Mods** section
4. Click **Import mods** and select `Config/zen/zen-mods-export.json`

### 7. Vesktop (Discord client)

Install Vesktop:

```bash
paru -S vesktop
```

Install the [system24](https://github.com/refact0r/system24) theme (required for Vesktop colors to work correctly):

```bash
mkdir -p ~/.config/vesktop/themes
wget https://raw.githubusercontent.com/refact0r/system24/refs/heads/main/theme/system24.theme.css -O ~/.config/vesktop/themes/system24.theme.css
```

Then open Vesktop, go to **Settings > Themes** and enable the **system24** theme.

### 8. Optional — OpenCode

**OpenCode** (AI coding assistant) — `paru -S opencode-bin`

To apply the Matugen theme, open OpenCode, type `/themes` in the command bar, and select the **matugen** theme.
