#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "🚀 Setting up dotfiles for Termux..."
echo ""

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Install dependencies
echo "📦 Installing dependencies..."
bash "$SCRIPT_DIR/install-dependencies-termux.sh"

# Backup existing configs
if [ -f "$HOME/.zshrc" ]; then
    echo "💾 Backing up existing .zshrc to .zshrc.backup"
    cp "$HOME/.zshrc" "$HOME/.zshrc.backup"
fi

if [ -f "$HOME/.p10k.zsh" ]; then
    echo "💾 Backing up existing .p10k.zsh to .p10k.zsh.backup"
    cp "$HOME/.p10k.zsh" "$HOME/.p10k.zsh.backup"
fi

if [ -f "$HOME/.gitconfig" ]; then
    echo "💾 Backing up existing .gitconfig to .gitconfig.backup"
    cp "$HOME/.gitconfig" "$HOME/.gitconfig.backup"
fi

# Symlink configs
echo "🔗 Creating symlinks..."
ln -sf "$SCRIPT_DIR/zshrc-termux" "$HOME/.zshrc"
ln -sf "$SCRIPT_DIR/p10k.zsh" "$HOME/.p10k.zsh"
ln -sf "$SCRIPT_DIR/gitconfig" "$HOME/.gitconfig"

echo ""
echo "✅ Dotfiles setup complete!"
echo ""
echo "📝 Next steps:"
echo "  1. Change your default shell to zsh:"
echo "     chsh -s zsh"
echo ""
echo "  2. Exit and restart Termux"
echo ""
echo "  3. First time you open Termux, run 'p10k configure' to set up your prompt"
echo ""
echo "  4. Install Termux:Styling app from F-Droid or Play Store for better fonts"
echo ""
echo "  5. Run 'termux-setup-storage' to access phone storage"
echo ""
echo "  6. Create ~/.zshrc.local for machine-specific configs (API keys, etc.)"
echo ""
