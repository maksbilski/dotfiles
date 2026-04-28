[[ $- != *i* ]] && return

if [[ "$OSTYPE" == "darwin"* ]]; then
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

for f in "$HOME/.bashrc.d/envs" \
         "$HOME/.bashrc.d/shell" \
         "$HOME/.bashrc.d/aliases" \
         "$HOME/.bashrc.d/functions" \
         "$HOME/.bashrc.d/init"; do
  [[ -f "$f" ]] && . "$f"
done

[[ -f "$HOME/.bashrc.d/inputrc" ]] && bind -f "$HOME/.bashrc.d/inputrc"

[[ -f "$HOME/.bashrc.local" ]] && . "$HOME/.bashrc.local"
