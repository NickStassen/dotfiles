#!/bin/bash
set -e

echo "🚀 Installing dotfiles..."

# Backup existing files
backup_dir="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$backup_dir"

for file in ~/.zshrc ~/.p10k.zsh ~/.gitconfig; do
    if [ -f "$file" ]; then
        echo "📦 Backing up $file to $backup_dir"
        cp "$file" "$backup_dir/"
    fi
done

# Create symlinks
echo "🔗 Creating symlinks..."
ln -sf "$HOME/dotfiles/zshrc" "$HOME/.zshrc"
ln -sf "$HOME/dotfiles/p10k.zsh" "$HOME/.p10k.zsh"
ln -sf "$HOME/dotfiles/gitconfig" "$HOME/.gitconfig"

echo "✅ Dotfiles installed!"
echo ""
echo "Next steps:"
echo "1. Install dependencies: ./install-dependencies.sh"
echo "2. Create ~/.zshrc.local with your LINEAR_API_KEY"
echo "3. Reload shell: source ~/.zshrc"
