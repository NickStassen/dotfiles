#!/bin/bash
set -e

echo "📦 Installing dependencies..."

# Detect OS
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
fi

# Install based on OS
if [ "$OS" = "ubuntu" ] || [ "$OS" = "debian" ]; then
    echo "🐧 Detected Ubuntu/Debian"

    # Update package list
    sudo apt-get update

    # Install modern CLI tools
    sudo apt-get install -y \
        zsh \
        git \
        curl \
        wget \
        jq \
        bat \
        fd-find \
        ripgrep \
        fzf \
        zoxide \
        xdotool \
        wmctrl \
        zsh-syntax-highlighting \
        xsel

    # Install Nerd Fonts (MesloLGS NF - recommended for Powerlevel10k)
    if ! fc-list | grep -qi "MesloLGS"; then
        echo "Installing MesloLGS Nerd Font..."
        mkdir -p ~/.local/share/fonts
        cd ~/.local/share/fonts
        curl -fLO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
        curl -fLO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
        curl -fLO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
        curl -fLO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
        fc-cache -fv
        cd -
        echo "✅ MesloLGS NF font installed"
    fi

    # Install delta
    if ! command -v delta &> /dev/null; then
        echo "Installing git-delta..."
        wget https://github.com/dandavison/delta/releases/download/0.18.2/git-delta_0.18.2_amd64.deb
        sudo dpkg -i git-delta_0.18.2_amd64.deb
        rm git-delta_0.18.2_amd64.deb
    fi

    # Install GitHub CLI
    if ! command -v gh &> /dev/null; then
        echo "Installing GitHub CLI..."
        wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
        echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list
        sudo apt-get update
        sudo apt-get install -y gh
    fi

    # Install eza (modern ls replacement) from GitHub releases
    if ! command -v eza &> /dev/null; then
        echo "Installing eza from GitHub releases..."
        EZA_VERSION=$(curl -s https://api.github.com/repos/eza-community/eza/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
        wget -qO /tmp/eza.tar.gz "https://github.com/eza-community/eza/releases/download/${EZA_VERSION}/eza_x86_64-unknown-linux-gnu.tar.gz"
        sudo tar -xzf /tmp/eza.tar.gz -C /usr/local/bin
        rm /tmp/eza.tar.gz
        echo "✅ eza ${EZA_VERSION} installed"
    fi

elif [ "$OS" = "darwin" ]; then
    echo "🍎 Detected macOS"

    # Install Homebrew if not present
    if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # Install tools via Homebrew
    brew install \
        zsh \
        git \
        jq \
        bat \
        eza \
        fd \
        ripgrep \
        fzf \
        zoxide \
        git-delta \
        gh
fi

# Install Oh-My-Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Powerlevel10k
if [ ! -d "$HOME/powerlevel10k" ]; then
    echo "Installing Powerlevel10k..."
    # Clone p10k to the correct oh-my-zsh location
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Install ZSH plugins
echo "Installing ZSH plugins..."

# zsh-autosuggestions
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# fzf-tab
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab" ]; then
    git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab
    chmod -R 755 ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab
fi

# Install Deno (for Linear CLI)
if ! command -v deno &> /dev/null; then
    echo "Installing Deno..."
    curl -fsSL https://deno.land/install.sh | sh
fi

# Install Linear CLI
if [ ! -f "$HOME/.deno/bin/linear" ]; then
    echo "Installing Linear CLI..."
    "$HOME/.deno/bin/deno" install --global --allow-all --name linear --force https://jsr.io/@schpet/linear-cli/1.5.0/src/main.ts
fi

echo ""
echo "✅ All dependencies installed!"
echo ""
echo "⚠️  IMPORTANT: Set up Linear CLI configuration"
echo "Create ~/.zshrc.local with:"
echo ""
echo "# Machine-specific secrets and configuration"
echo "export LINEAR_API_KEY=your_api_key_here"
echo ""
echo "# Linear CLI - Global team defaults (avoids needing .linear.toml in each repo)"
echo "export LINEAR_TEAM_ID=\"CT\""
echo "export LINEAR_WORKSPACE=\"lighthouseavionics\""
echo "export LINEAR_ISSUE_SORT=\"manual\""
