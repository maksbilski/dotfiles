[[ $- != *i* ]] && return

if [[ "$OSTYPE" == "darwin"* ]]; then
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi

  [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && \
    . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
fi

export PATH="$HOME/.local/bin:$PATH"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export EDITOR=nvim
export VISUAL=nvim

alias vim=nvim
alias vi=nvim
alias claude='claude --dangerously-skip-permissions'
alias ll='ls -lah'
alias la='ls -A'

if command -v eza >/dev/null 2>&1; then
  alias ls='eza'
  alias ll='eza -lah --git'
  alias tree='eza --tree'
fi

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate bash)"
fi

if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --bash)" 2>/dev/null || true
fi

if [[ -d "$HOME/google-cloud-sdk" ]]; then
  [[ -f "$HOME/google-cloud-sdk/path.bash.inc" ]] && . "$HOME/google-cloud-sdk/path.bash.inc"
  [[ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]] && . "$HOME/google-cloud-sdk/completion.bash.inc"
fi

[[ -f "$HOME/.bashrc.local" ]] && . "$HOME/.bashrc.local"
