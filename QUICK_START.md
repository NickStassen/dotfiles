# Quick Start Guide

## On Your Current Machine (First Time Setup)

### 1. Initialize the Dotfiles Repository
```bash
cd ~/dotfiles-starter
./setup-repo.sh
```

This will:
- Move `dotfiles-starter` to `~/dotfiles`
- Copy your current `.zshrc`, `.gitconfig`, and `.p10k.zsh`
- Extract your LINEAR_API_KEY to `~/.zshrc.local` (not tracked in git)
- Initialize a git repository

### 2. Create GitHub Repository
1. Go to https://github.com/new
2. Create a repository named `dotfiles` (can be private)
3. Don't initialize with README (we already have one)

### 3. Push to GitHub
```bash
cd ~/dotfiles
git remote add origin git@github.com:YOUR_USERNAME/dotfiles.git
git branch -M main
git push -u origin main
```

## On Other Machines (New Installation)

### 1. Clone the Repository
```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Install Dotfiles
```bash
./install.sh
```

This creates symlinks from `~/dotfiles/*` to `~/.zshrc`, `~/.gitconfig`, etc.

### 3. Install Dependencies
```bash
./install-dependencies.sh
```

This installs all the tools (zsh, oh-my-zsh, modern CLI tools, etc.)

### 4. Set Up Secrets and Linear Configuration
```bash
cat > ~/.zshrc.local << 'EOF'
# Machine-specific secrets and configuration
export LINEAR_API_KEY=your_api_key_here

# Linear CLI - Global team defaults (avoids needing .linear.toml in each repo)
export LINEAR_TEAM_ID="CT"
export LINEAR_WORKSPACE="lighthouseavionics"
export LINEAR_ISSUE_SORT="manual"
EOF
```

### 5. Reload Shell
```bash
source ~/.zshrc
```

## Keeping Multiple Machines in Sync

### After Making Changes
```bash
cd ~/dotfiles
git add -A
git commit -m "Update configuration"
git push
```

### On Other Machines
```bash
cd ~/dotfiles
git pull
source ~/.zshrc  # Reload if .zshrc changed
```

## What's Different on Each Machine

Some things are **machine-specific** and should NOT be in the dotfiles repo:

- Monitor configurations (if different screen setups)
- API keys and secrets (use `~/.zshrc.local`)
- Machine-specific paths
- Company-specific configs

For these, use `~/.zshrc.local` which is automatically loaded but not tracked in git.

## Troubleshooting

### Symlinks Don't Update
If you edit `~/.zshrc` directly instead of `~/dotfiles/zshrc`, changes won't sync.
Always edit files in `~/dotfiles/` directory.

### Missing Dependencies on New Machine
Run `./install-dependencies.sh` again - it's idempotent and safe to re-run.

### Different Monitor Setup
Edit the monitor coordinates in the `work` function for your specific setup.
Use `xrandr --query` to see your monitor positions.

## Alternative: Manual Setup (Without Scripts)

If you prefer manual control:

```bash
# Copy files
mkdir ~/dotfiles
cp ~/.zshrc ~/dotfiles/zshrc
cp ~/.gitconfig ~/dotfiles/gitconfig
cp ~/.p10k.zsh ~/dotfiles/p10k.zsh

# Create symlinks
ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/p10k.zsh ~/.p10k.zsh

# Commit to git
cd ~/dotfiles
git init
git add .
git commit -m "Initial commit"
git remote add origin git@github.com:YOUR_USERNAME/dotfiles.git
git push -u origin main
```

## Advanced: Using GNU Stow (Alternative Method)

Some users prefer GNU Stow for symlink management:

```bash
sudo apt-get install stow

# Structure: ~/dotfiles/.zshrc → ~/.zshrc
cd ~/dotfiles
stow .
```

This is more advanced but cleaner for managing many dotfiles.
