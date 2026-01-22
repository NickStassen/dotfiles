#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "📦 Installing dependencies for Termux..."

# Update package list
pkg update -y

# Install core tools
echo "Installing core tools..."
pkg install -y \
    zsh \
    git \
    curl \
    wget \
    jq \
    nodejs

# Install modern CLI tools
echo "Installing modern CLI tools..."
pkg install -y \
    bat \
    eza \
    fd \
    ripgrep \
    fzf \
    zoxide

# Install Termux API for clipboard and other features
echo "Installing Termux API..."
pkg install -y termux-api

# Install Oh-My-Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Powerlevel10k
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Install ZSH plugins
echo "Installing ZSH plugins..."

# zsh-autosuggestions
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# zsh-syntax-highlighting
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# fzf-tab
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab" ]; then
    git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab
    chmod -R 755 ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab
fi

# Install Claude Code via npm
if ! command -v claude &> /dev/null; then
    echo "Installing Claude Code..."
    npm install -g @anthropic-ai/claude-code
fi

echo ""
echo "✅ All dependencies installed!"
echo ""
echo "⚠️  IMPORTANT: Configure fonts for Powerlevel10k"
echo "Run 'p10k configure' after setting up your .zshrc to configure the prompt."
echo ""
echo "💡 TERMUX-SPECIFIC NOTES:"
echo "  - Clipboard: Use 'termux-clipboard-set' and 'termux-clipboard-get'"
echo "  - Fonts: Install Termux:Styling app for p10k font support"
echo "  - Storage: Run 'termux-setup-storage' to access phone storage"
echo ""
