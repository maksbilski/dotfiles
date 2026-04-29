#!/usr/bin/env bash
set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/dotfiles}"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

PACKAGES=(
  bash
  git
  tmux
  starship
  nvim
  ghostty
  alacritty
  kitty
  lazygit
  btop
  fastfetch
  aerospace
  sketchybar
)

mkdir -p "$BACKUP_DIR"

backup_if_real() {
  local target="$1"
  if [[ -e "$target" && ! -L "$target" ]]; then
    local rel="${target#$HOME/}"
    local dest="$BACKUP_DIR/$rel"
    mkdir -p "$(dirname "$dest")"
    mv "$target" "$dest"
    echo "    backed up $target → $dest"
  elif [[ -L "$target" ]]; then
    rm "$target"
  fi
}

link_tree() {
  local src="$1"
  local dest="$2"

  if [[ -d "$src" && ! -L "$src" ]]; then
    mkdir -p "$dest"
    local entry
    for entry in "$src"/* "$src"/.[!.]*; do
      [[ -e "$entry" ]] || continue
      local name
      name="$(basename "$entry")"
      link_tree "$entry" "$dest/$name"
    done
  else
    backup_if_real "$dest"
    ln -snf "$src" "$dest"
    echo "    linked $dest → $src"
  fi
}

for pkg in "${PACKAGES[@]}"; do
  pkg_dir="$DOTFILES/$pkg"
  [[ -d "$pkg_dir" ]] || continue
  echo "==> $pkg"
  shopt -s dotglob nullglob
  for entry in "$pkg_dir"/*; do
    name="$(basename "$entry")"
    [[ "$name" == "README.md" ]] && continue
    link_tree "$entry" "$HOME/$name"
  done
  shopt -u dotglob nullglob
done

echo "==> Backups (if any) at: $BACKUP_DIR"
