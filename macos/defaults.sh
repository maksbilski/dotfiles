#!/usr/bin/env bash
set -euo pipefail

echo "==> Applying macOS defaults. Some changes need a logout to take effect."

# Keyboard: fast key repeat (matches Hyprland repeat_rate=40, repeat_delay=600)
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Disable “natural” scrolling? Linux uses natural=true in touchpad. Keep mac default.
# defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

# Save panel: expanded by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Disable autocorrect / smart quotes (annoying for code)
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Finder: show hidden, extensions, path bar, status bar
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"  # search current folder
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Disable .DS_Store on network/USB
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Dock: small, autohide, fast
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-time-modifier -float 0.15
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock mru-spaces -bool false

# Mission Control: don’t rearrange spaces (required for AeroSpace)
defaults write com.apple.dock mru-spaces -bool false

# Screenshots: save to ~/Screenshots, no shadow
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"
defaults write com.apple.screencapture disable-shadow -bool true
defaults write com.apple.screencapture type -string "png"

# Trackpad: tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Menu bar: show battery percentage
defaults write com.apple.controlcenter "NSStatusItem Visible Battery" -bool true

# Restart affected apps
for app in "Dock" "Finder" "SystemUIServer"; do
  killall "$app" >/dev/null 2>&1 || true
done

echo "==> macOS defaults applied. Log out for keyboard/global changes to settle."
