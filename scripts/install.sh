#!/usr/bin/env bash
set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/dotfiles}"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This installer targets macOS." >&2
  exit 1
fi

if ! xcode-select -p >/dev/null 2>&1; then
  echo "==> Installing Xcode Command Line Tools (follow the GUI prompt)…"
  xcode-select --install || true
  read -r -p "Press Enter once Command Line Tools finish installing… " _
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "==> Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

echo "==> brew bundle"
brew tap homebrew/bundle 2>/dev/null || true
brew bundle --file="$DOTFILES/Brewfile"

bash "$DOTFILES/scripts/link.sh"

read -r -p "Apply macOS defaults (dock, finder, key-repeat tweaks)? [y/N] " ans
if [[ "${ans,,}" == "y" ]]; then
  bash "$DOTFILES/macos/defaults.sh"
fi

if [[ ! -f "$HOME/.bashrc.local" && -f "$DOTFILES/bash/.bashrc.local.example" ]]; then
  cp "$DOTFILES/bash/.bashrc.local.example" "$HOME/.bashrc.local"
  echo "==> Wrote ~/.bashrc.local — fill in secrets there (gitignored)."
fi

NEW_BASH="$(brew --prefix)/bin/bash"
if [[ -x "$NEW_BASH" ]] && ! grep -qx "$NEW_BASH" /etc/shells; then
  echo "==> Adding $NEW_BASH to /etc/shells (sudo)"
  echo "$NEW_BASH" | sudo tee -a /etc/shells >/dev/null
fi
if [[ "$SHELL" != "$NEW_BASH" ]]; then
  read -r -p "Switch login shell to brew bash ($NEW_BASH)? [y/N] " s
  if [[ "${s,,}" == "y" ]]; then
    chsh -s "$NEW_BASH"
  fi
fi

echo "==> Done. Open a new terminal."
echo "    Launch AeroSpace from /Applications. Grant Accessibility permission when prompted."
