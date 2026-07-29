#!/usr/bin/env bash
# Bootstrap a new machine: install Homebrew, install packages from Brewfile,
# stow every package directory in this repo, and apply macOS defaults.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

if ! command -v brew >/dev/null 2>&1; then
  echo "==> Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Homebrew doesn't put itself on PATH after a fresh install.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

echo "==> brew bundle"
brew bundle --file="$DOTFILES_DIR/Brewfile"

echo "==> Stowing packages"
for pkg_path in "$DOTFILES_DIR"/*/; do
  pkg="$(basename "$pkg_path")"
  [[ "$pkg" == ".git" ]] && continue
  echo "  - $pkg"
  stow --target="$HOME" --restow "$pkg"
done

if [[ "$(uname)" == "Darwin" ]]; then
  echo "==> macOS defaults"
  "$DOTFILES_DIR/macos.sh"
fi

echo "==> Done"
