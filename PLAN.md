# Migration plan

One-time plan for moving existing configs into this repo, package by package. All commands are run from `~/dotfiles/`. See [README.md](README.md) for the ongoing stow/antidote conventions.

---

## Step 2 — zsh

This is the most involved package. Your zsh config lives in `~/.config/zsh/` via `ZDOTDIR`. The live directory stays as a real directory (with history, compdump, etc. inside it); stow creates individual file-level symlinks within it.

- [x] **2a. Create the package structure**

  ```zsh
  mkdir -p ~/dotfiles/zsh/.config/zsh
  ```

- [x] **2b. Move tracked files into the package**

  ```zsh
  mv ~/.zshenv                    ~/dotfiles/zsh/.zshenv
  mv ~/.config/zsh/.zshenv        ~/dotfiles/zsh/.config/zsh/.zshenv
  mv ~/.config/zsh/.zshrc         ~/dotfiles/zsh/.config/zsh/.zshrc
  mv ~/.config/zsh/alias.zsh      ~/dotfiles/zsh/.config/zsh/alias.zsh
  ```

- [x] **2c. Remove the bundled plugin** (antidote will manage this)

  ```zsh
  rm -rf ~/.config/zsh/zsh-syntax-highlighting
  ```

- [x] **2d. Create `.zsh_plugins.txt`**

  ```zsh
  touch ~/dotfiles/zsh/.config/zsh/.zsh_plugins.txt
  ```

  Open it and add your plugins. At minimum:

  ```txt
  zsh-users/zsh-syntax-highlighting
  ```

  Other common additions: `zsh-users/zsh-autosuggestions`, `zsh-users/zsh-completions`

  > Currently only `zsh-users/zsh-completions kind:fpath path:src` is listed —
  > `zsh-syntax-highlighting` isn't in there, so double check that's intentional
  > before checking off 2h.

- [x] **2e. Edit `.zshrc` for antidote**

  Open `~/dotfiles/zsh/.config/zsh/.zshrc` and make two changes:

  1. The `source ~/.config/zsh/*.zsh` glob will conflict with antidote's bundle file later.
     Replace it with explicit sources:

     ```zsh
     # before
     source ~/.config/zsh/*.zsh

     # after
     source ${ZDOTDIR}/alias.zsh
     ```

  2. At the bottom, replace the hardcoded syntax-highlighting source line:

     ```zsh
     # remove this
     source /Users/sam/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

     # replace with
     source $(antidote home)/antidote.zsh
     antidote load ${ZDOTDIR}/.zsh_plugins.txt
     ```

- [x] **2f. Run stow**

  ```zsh
  cd ~/dotfiles && stow zsh
  ```

- [x] **2g. Verify**

  ```zsh
  ls -la ~/.zshenv ~/.config/zsh/.zshenv ~/.config/zsh/.zshrc ~/.config/zsh/alias.zsh
  ```

  All four show as symlinks (`->`) pointing into `~/dotfiles/zsh/`.

- [ ] **2h. Reload and test**

  ```zsh
  exec zsh
  ```

  Check that syntax highlighting works and aliases are available. (See the note on 2d —
  worth confirming syntax highlighting is actually active before checking this off.)

- [x] **2i. `env.zsh`** *(added after the original plan — not in the initial migration)*

  Sets `PYTHONSTARTUP` for the [python](python/.config/pythonrc.py) package:

  ```zsh
  export PYTHONSTARTUP="$HOME/.config/pythonrc.py"
  ```

  Created and symlinked via `stow zsh`, but nothing currently `source`s it —
  `.zshrc` only explicitly sources `alias.zsh`. The same `PYTHONSTARTUP` line
  is also already set directly in `.zshenv`, so `env.zsh` looks unused/duplicated
  right now. Worth deciding: wire it into `.zshrc` (and drop the line from
  `.zshenv`), or delete `env.zsh`.

---

## Step 3 — git

`~/.config/git/` will become a directory symlink, so remove the now-empty dir after moving.

- [ ] Move files and stow

  ```zsh
  mkdir -p ~/dotfiles/git/.config/git

  mv ~/.gitconfig                  ~/dotfiles/git/.gitconfig
  mv ~/.config/git/ignore          ~/dotfiles/git/.config/git/ignore
  rmdir ~/.config/git

  cd ~/dotfiles && stow git
  ```

- [ ] Verify

  ```zsh
  ls -la ~/.gitconfig ~/.config/git
  ```

---

## Step 4 — doom

Move the whole directory; stow creates a directory-level symlink for `~/.config/doom`.
`custom.el` is auto-rewritten by Emacs — it's tracked here but will appear modified often.
If you want to ignore it, add `doom/.config/doom/custom.el` to `~/dotfiles/.gitignore`.

- [ ] Move and stow

  ```zsh
  mkdir -p ~/dotfiles/doom/.config

  mv ~/.config/doom                ~/dotfiles/doom/.config/doom

  cd ~/dotfiles && stow doom
  ```

- [ ] Verify

  ```zsh
  ls -la ~/.config/doom
  # should be a symlink -> ~/dotfiles/doom/.config/doom
  ```

---

## Step 5 — kitty

Same pattern as doom. Delete the `.bak` file before committing — it's a one-off snapshot, not config.

- [ ] Move and stow

  ```zsh
  mkdir -p ~/dotfiles/kitty/.config

  mv ~/.config/kitty               ~/dotfiles/kitty/.config/kitty
  rm ~/dotfiles/kitty/.config/kitty/kitty.conf.bak

  cd ~/dotfiles && stow kitty
  ```

- [ ] Verify

  ```zsh
  ls -la ~/.config/kitty
  ```

---

## Step 6 — gh

`hosts.yml` contains auth tokens — **do not track it**. Because `~/.config/gh/` still exists
(with `hosts.yml` inside), stow recurses and creates only a file-level symlink for `config.yml`.

- [ ] Move and stow

  ```zsh
  mkdir -p ~/dotfiles/gh/.config/gh

  mv ~/.config/gh/config.yml       ~/dotfiles/gh/.config/gh/config.yml

  cd ~/dotfiles && stow gh
  ```

- [ ] Verify

  ```zsh
  ls -la ~/.config/gh/config.yml
  # should be a symlink; hosts.yml next to it should still be a regular file
  ```

---

## Step 7 — .gitignore and initial commit

- [ ] Create `~/dotfiles/.gitignore`:

  ```gitignore
  # Emacs rewrites this via M-x customize
  doom/.config/doom/custom.el

  # gh auth tokens — never commit
  gh/.config/gh/hosts.yml
  ```

- [ ] Commit:

  ```zsh
  cd ~/dotfiles
  git add .
  git status        # review what's staged before committing
  git commit -m "Initial dotfiles: zsh, git, doom, kitty, gh"
  ```

---

## Step 8 — setup.sh

One-shot bootstrap script for a new machine: installs Homebrew if missing, runs
`brew bundle` against [Brewfile](Brewfile), stows every package directory in
this repo, then applies macOS defaults via [macos.sh](macos.sh). Lets a fresh
machine go from "clone this repo" to "fully configured" with a single command.

- [x] Create `~/dotfiles/setup.sh`
- [x] Create `~/dotfiles/macos.sh` (Dock, Finder, keyboard, screenshots, misc —
      `defaults write` settings, gated to Darwin only in setup.sh)
- [x] `chmod +x ~/dotfiles/setup.sh ~/dotfiles/macos.sh`
- [ ] Test on this machine (everything already installed, so `brew bundle` and
      `stow` should both report no changes / succeed as no-ops)
