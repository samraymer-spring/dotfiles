#!/usr/bin/env bash
# macOS system preferences, applied via `defaults write`.
# Run standalone or via setup.sh (which sources this only on Darwin).
set -euo pipefail

echo "==> Dock"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock minimize-to-application -bool true

echo "==> Finder"
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

echo "==> Keyboard"
defaults write NSGlobalDomain KeyRepeat -int 1

echo "==> Screenshots"
mkdir -p "$HOME/Desktop/Screenshots"
defaults write com.apple.screencapture location "$HOME/Desktop/Screenshots"
defaults write com.apple.screencapture disable-shadow -bool true

echo "==> Misc"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

echo "==> Restarting affected apps"
for app in Dock Finder SystemUIServer; do
  killall "$app" >/dev/null 2>&1 || true
done

echo "==> Done. Some settings (e.g. key repeat rate) may require logout to fully apply."
