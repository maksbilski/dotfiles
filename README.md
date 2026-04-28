# dotfiles

macOS + AeroSpace setup. Migrated from Omarchy/Hyprland.

## Install on a fresh Mac

```bash
git clone git@github.com:maksbilski/dotfiles.git ~/dotfiles
cd ~/dotfiles
bash scripts/install.sh
```

The installer will:

1. Install Xcode Command Line Tools (if missing)
2. Install Homebrew (if missing)
3. `brew bundle` everything in `Brewfile` (apps, casks, fonts)
4. Symlink configs into `$HOME` (with timestamped backups of anything it would overwrite)
5. Optionally apply `macos/defaults.sh` (Dock, Finder, key-repeat, screenshot dir)
6. Seed `~/.bashrc.local` from the example for secrets

After install:

- Launch **AeroSpace** from `/Applications` and grant Accessibility permission.
- Optional: System Settings → Desktop & Dock → uncheck *“Automatically rearrange Spaces”*.
- Open **Raycast** and disable Spotlight (`⌘Space`) if you want Raycast on that hotkey.
- Edit `~/.bashrc.local` with your `EXA_API_KEY` and any other secrets.

## Layout

Each top-level dir is a self-contained "package" mirroring `$HOME`. `scripts/link.sh` walks each package and symlinks files to the matching path under `$HOME`.

```
dotfiles/
├── aerospace/.aerospace.toml          → ~/.aerospace.toml
├── alacritty/.config/alacritty/…      → ~/.config/alacritty/…
├── bash/.bashrc, .bash_profile        → ~/.bashrc, ~/.bash_profile
├── btop/.config/btop/…                → ~/.config/btop/…
├── fastfetch/.config/fastfetch/…      → ~/.config/fastfetch/…
├── ghostty/.config/ghostty/config     → ~/.config/ghostty/config
├── git/.gitconfig                     → ~/.gitconfig
├── kitty/.config/kitty/kitty.conf     → ~/.config/kitty/kitty.conf
├── lazygit/.config/lazygit/…          → ~/.config/lazygit/…
├── nvim/.config/nvim/…                → ~/.config/nvim/…
├── starship/.config/starship.toml     → ~/.config/starship.toml
├── tmux/.tmux.conf                    → ~/.tmux.conf
├── Brewfile
├── macos/defaults.sh
└── scripts/{install,link,unlink}.sh
```

## Keybindings (AeroSpace)

Mod-key plan:
- **`alt`** = window manager (move/resize/workspaces). AeroSpace default.
- **`cmd+shift`** = app launchers. Mirrors your old `SUPER+SHIFT+X` Hyprland bindings 1:1.
- **`cmd+enter`** = new Ghostty terminal (mirrors `SUPER+RETURN`).

| Old (Hyprland)     | New (AeroSpace / macOS) | Action                |
|--------------------|--------------------------|-----------------------|
| `SUPER+H/J/K/L`    | `alt+h/j/k/l`            | Focus window          |
| `SUPER+SHIFT+H/…`  | `alt+shift+h/j/k/l`      | Move window           |
| `SUPER+1..9`       | `alt+1..9`               | Switch workspace      |
| `SUPER+SHIFT+1..9` | `alt+shift+1..9`         | Move window to ws     |
| `SUPER+S` (resize) | `cmd+s` then `h/j/k/l`   | Resize submode        |
| `SUPER+UP`         | `alt+slash`              | Toggle tile direction |
| `SUPER+C`          | `cmd+w`                  | Close window (native) |
| `SUPER+R`          | `cmd+space`              | Launcher (Raycast)    |
| `SUPER+RETURN`     | `cmd+enter`              | Terminal              |
| `SUPER+SHIFT+B`    | `cmd+shift+b`            | Browser               |
| `SUPER+SHIFT+M`    | `cmd+shift+m`            | Spotify               |
| `SUPER+SHIFT+N`    | `cmd+shift+n`            | Editor (Cursor)       |
| `SUPER+SHIFT+G`    | `cmd+shift+g`            | Signal                |
| `SUPER+SHIFT+O`    | `cmd+shift+o`            | Obsidian              |
| `SUPER+SHIFT+/`    | `cmd+shift+/`            | 1Password             |
| `SUPER+SHIFT+A`    | `cmd+shift+a`            | ChatGPT (web)         |
| `SUPER+SHIFT+Y`    | `cmd+shift+y`            | YouTube               |
| `SUPER+SHIFT+X`    | `cmd+shift+x`            | X / Twitter           |

Reload AeroSpace config: `alt+shift+c`.

## Secrets

Anything sensitive (API keys, tokens) goes in `~/.bashrc.local` — gitignored. The installer seeds it from `bash/.bashrc.local.example`.

## Updating

```bash
cd ~/dotfiles && git pull
bash scripts/link.sh        # re-link if anything new was added
brew bundle --file=Brewfile # apply Brewfile changes
```

## Removing

```bash
bash scripts/unlink.sh
```

Removes only symlinks pointing into this repo. Original backups (if any) live in `~/.dotfiles-backup-*`.

## What got dropped from the Linux setup

No macOS analogue / handled by macOS itself:

- Hyprland (→ AeroSpace)
- Waybar (→ macOS menu bar)
- Walker (→ Raycast)
- Mako (→ Notification Center)
- Hypridle / Hyprlock (→ macOS Lock Screen + Caffeine cask if needed)
- swayosd, brightnessctl, pactl, makima
- omarchy-* commands and Linux-only paths in `.bashrc`
