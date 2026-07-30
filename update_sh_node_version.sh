#!/bin/sh
# Re-point ~/.local/bin/{node,npm,npx} at nvm's current default version.
# Run after `nvm alias default <version>` so /bin/sh (hooks, cron, etc.)
# can find node without sourcing nvm.sh.

export NVM_DIR="$HOME/.nvm"
DEFAULT_VERSION="$(. "$NVM_DIR/nvm.sh" && nvm version default)"

ln -sf "$NVM_DIR/versions/node/$DEFAULT_VERSION/bin/node" ~/.local/bin/node
ln -sf "$NVM_DIR/versions/node/$DEFAULT_VERSION/bin/npm" ~/.local/bin/npm
ln -sf "$NVM_DIR/versions/node/$DEFAULT_VERSION/bin/npx" ~/.local/bin/npx

echo "Linked ~/.local/bin/{node,npm,npx} -> $DEFAULT_VERSION"
