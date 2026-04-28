#!/usr/bin/env bash
set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/dotfiles}"

remove_links() {
  local dir="$1"
  shopt -s dotglob nullglob
  for entry in "$dir"/*; do
    if [[ -L "$entry" ]]; then
      local target
      target="$(readlink "$entry")"
      if [[ "$target" == "$DOTFILES"/* ]]; then
        rm "$entry"
        echo "    unlinked $entry"
      fi
    elif [[ -d "$entry" ]]; then
      remove_links "$entry"
    fi
  done
  shopt -u dotglob nullglob
}

remove_links "$HOME"
remove_links "$HOME/.config"
echo "==> Done."
