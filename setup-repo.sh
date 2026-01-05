#!/bin/bash
set -e

echo "🎯 Setting up dotfiles repository..."

# Check if we're in the right directory
if [ ! -f "install.sh" ] || [ ! -f "README.md" ]; then
    echo "❌ Error: Please run this from the dotfiles-starter directory"
    exit 1
fi

# Move to home directory and rename
echo "📁 Moving dotfiles-starter to ~/dotfiles..."
cd ~
if [ -d "dotfiles" ]; then
    echo "⚠️  Warning: ~/dotfiles already exists!"
    read -p "Do you want to backup and replace it? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        mv dotfiles "dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
    else
        echo "❌ Aborting"
        exit 1
    fi
fi

mv dotfiles-starter dotfiles
cd dotfiles

# Copy current configuration files (without leading dot)
echo "📋 Copying configuration files..."
cp ~/.zshrc zshrc
cp ~/.gitconfig gitconfig

if [ -f ~/.p10k.zsh ]; then
    cp ~/.p10k.zsh p10k.zsh
else
    echo "⚠️  Warning: ~/.p10k.zsh not found, skipping"
fi

# Remove LINEAR_API_KEY from zshrc (move to .zshrc.local)
echo "🔐 Securing API key..."
if grep -q "export LINEAR_API_KEY=" zshrc; then
    # Extract the API key
    API_KEY=$(grep "export LINEAR_API_KEY=" zshrc | cut -d'=' -f2)

    # Remove it from zshrc
    sed -i '/export LINEAR_API_KEY=/d' zshrc

    # Add placeholder comment
    echo "" >> zshrc
    echo "# Load local secrets (not tracked in git)" >> zshrc
    echo "[ -f ~/.zshrc.local ] && source ~/.zshrc.local" >> zshrc

    # Create .zshrc.local
    cat > ~/.zshrc.local << EOF
# Machine-specific secrets and configuration
export LINEAR_API_KEY=$API_KEY
EOF

    echo "✅ API key moved to ~/.zshrc.local"
fi

# Make scripts executable
chmod +x install.sh install-dependencies.sh setup-repo.sh

# Initialize git repository
echo "🔧 Initializing git repository..."
git init
git add .
git commit -m "Initial dotfiles commit

Includes:
- ZSH configuration with custom functions
- Powerlevel10k theme config
- Git configuration with delta
- Installation scripts
- README with setup instructions"

echo ""
echo "✅ Dotfiles repository ready!"
echo ""
echo "Next steps:"
echo "1. Create a GitHub repository at https://github.com/new"
echo "2. Run these commands:"
echo "   cd ~/dotfiles"
echo "   git remote add origin git@github.com:YOUR_USERNAME/dotfiles.git"
echo "   git push -u origin main"
echo ""
echo "3. On other machines, clone and install:"
echo "   git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles"
echo "   cd ~/dotfiles"
echo "   ./install.sh"
echo "   ./install-dependencies.sh"
echo ""
echo "4. Don't forget to set LINEAR_API_KEY on new machines in ~/.zshrc.local"
