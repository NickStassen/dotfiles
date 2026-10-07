#!/bin/bash
set -e

echo "🚀 Installing dotfiles..."

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
IPY="$HOME/.ipython/profile_default"

# Backup existing files
backup_dir="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$backup_dir"

for file in ~/.zshrc ~/.p10k.zsh ~/.gitconfig "$IPY/ipython_config.py" "$IPY/startup/00-imports.ipy"; do
    if [ -f "$file" ]; then
        echo "📦 Backing up $file to $backup_dir"
        cp "$file" "$backup_dir/"
    fi
done

# Create symlinks
echo "🔗 Creating symlinks..."
ln -sf "$DOTFILES/zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/p10k.zsh" "$HOME/.p10k.zsh"
ln -sf "$DOTFILES/gitconfig" "$HOME/.gitconfig"
mkdir -p "$IPY/startup"
ln -sf "$DOTFILES/ipython/ipython_config.py" "$IPY/ipython_config.py"
ln -sf "$DOTFILES/ipython/startup/00-imports.ipy" "$IPY/startup/00-imports.ipy"

# GNOME: Super+C opens an IPython calculator terminal
if command -v gsettings &> /dev/null; then
    K=org.gnome.settings-daemon.plugins.media-keys
    P=/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ipython-calc/
    cur=$(gsettings get $K custom-keybindings)
    if [[ $cur != *ipython-calc* ]]; then
        [[ $cur == "@as []" ]] && new="['$P']" || new="${cur%]}, '$P']"
        gsettings set $K custom-keybindings "$new"
    fi
    gsettings set $K.custom-keybinding:$P name 'IPython calculator'
    gsettings set $K.custom-keybinding:$P command 'gnome-terminal --title=calc -- python3 -m IPython'
    gsettings set $K.custom-keybinding:$P binding '<Super>c'
fi

echo "✅ Dotfiles installed!"
echo ""
echo "Next steps:"
echo "1. Install dependencies: ./install-dependencies.sh"
echo "2. Create ~/.zshrc.local with your LINEAR_API_KEY"
echo "3. Reload shell: source ~/.zshrc"
