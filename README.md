# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/). Each subdirectory is a **package** whose contents mirror the structure of `~`. Running `stow <package>` from this directory creates symlinks in `~` pointing back here.

Example: `zsh/.zshenv` → `~/.zshenv`, `zsh/.config/zsh/.zshrc` → `~/.config/zsh/.zshrc`

Plugins managed with [antidote](https://antidote.sh).

All `stow` commands are run from `~/dotfiles/`.

For the original migration plan (moving existing configs into this repo package by package), see [PLAN.md](PLAN.md).

---

## Bootstrap a new machine

```zsh
git clone <this-repo> ~/dotfiles
cd ~/dotfiles && ./setup.sh
```

Installs Homebrew if missing, runs `brew bundle` against [Brewfile](Brewfile), then
stows every package directory here. On macOS it also applies system defaults via
[macos.sh](macos.sh) (Dock, Finder, keyboard, screenshots, misc) — that script can
also be run standalone: `./macos.sh`.

---

## Adding a new package later

```zsh
mkdir -p ~/dotfiles/<name>/<path/mirroring/home>
mv ~/<original/path>  ~/dotfiles/<name>/<path/mirroring/home>
# if the original dir is now empty: rmdir ~/<original/path>
cd ~/dotfiles && stow <name>
```
