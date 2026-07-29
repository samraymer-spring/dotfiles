# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/). Each subdirectory is a **package** whose contents mirror the structure of `~`. Running `stow <package>` from this directory creates symlinks in `~` pointing back here.

Example: `zsh/.zshenv` → `~/.zshenv`, `zsh/.config/zsh/.zshrc` → `~/.config/zsh/.zshrc`

Plugins managed with [antidote](https://antidote.sh).

All `stow` commands are run from `~/dotfiles/`.

For the original migration plan (moving existing configs into this repo package by package), see [PLAN.md](PLAN.md).

---

## Adding a new package later

```zsh
mkdir -p ~/dotfiles/<name>/<path/mirroring/home>
mv ~/<original/path>  ~/dotfiles/<name>/<path/mirroring/home>
# if the original dir is now empty: rmdir ~/<original/path>
cd ~/dotfiles && stow <name>
```
