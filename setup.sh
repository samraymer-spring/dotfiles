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

echo "==> Stowing packages"
for pkg_path in "$DOTFILES_DIR"/*/; do
  pkg="$(basename "$pkg_path")"
  [[ "$pkg" == ".git" ]] && continue
  [[ "$pkg" == "git" && -n $GITHUB_CODESPACE_TOKEN ]] && continue
  echo "  - $pkg"
  stow --target="$HOME" --restow "$pkg"
done

echo "==> Install nvm for node"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.6/install.sh | bash

echo "==> Install rvm for ruby"
gpg2 --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable

echo "==> Install claude code"
curl -fsSL https://claude.ai/install.sh | bash

echo "==> Install caveman for claude"
curl -fsSL https://raw.githubusercontent.com/JuliusBrussee/caveman/main/install.sh | bash

echo "==> Install codegraph for claude"
curl -fsSL https://raw.githubusercontent.com/colbymchenry/codegraph/main/install.sh | sh
codegraph install --target=cursor,claude --yes       # explicit target list

echo "==> Install python uv"
curl -LsSf https://astral.sh/uv/install.sh | sh

echo "==> Trusting third-party taps"
brew trust --tap d12frosted/emacs-plus

echo "==> brew bundle"
brew bundle --file="$DOTFILES_DIR/Brewfile"

if [[ "$(uname)" == "Darwin" ]]; then
  echo "==> macOS defaults"
  cd "$DOTFILES_DIR/osx"
  source "./macos.sh"
fi

echo "==> Done"
