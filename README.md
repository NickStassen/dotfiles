# My Dotfiles

Terminal configuration with ZSH, Oh-My-Zsh, Powerlevel10k, and modern CLI tools.

## Features

- **ZSH** with Oh-My-Zsh framework
- **Powerlevel10k** theme for beautiful prompts
- **Modern CLI tools**: bat, eza, delta, zoxide, fzf, ripgrep
- **Custom functions**: `work` and `review-pr` for efficient development workflow
- **Linear CLI** integration for task management
- **GitHub CLI** for PR reviews
- **Multi-monitor workspace automation** (GNOME-specific)

## Quick Install

```bash
# Clone this repository
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles

# Run installation
cd ~/dotfiles
chmod +x install.sh install-dependencies.sh
./install.sh
./install-dependencies.sh

# Set up secrets and Linear configuration
cat > ~/.zshrc.local << 'EOF'
export LINEAR_API_KEY=your_api_key_here
export LINEAR_TEAM_ID="CT"
export LINEAR_WORKSPACE="lighthouseavionics"
export LINEAR_ISSUE_SORT="manual"
EOF

# Reload shell
source ~/.zshrc
```

## What Gets Installed

### Configuration Files (via symlinks)
- `~/.zshrc` → `~/dotfiles/zshrc`
- `~/.p10k.zsh` → `~/dotfiles/p10k.zsh`
- `~/.gitconfig` → `~/dotfiles/gitconfig`

### Dependencies
- ZSH shell with Oh-My-Zsh framework
- Powerlevel10k theme
- Modern CLI tools (bat, eza, delta, zoxide, fzf, fd, ripgrep)
- GitHub CLI (`gh`)
- Deno runtime
- Linear CLI
- Window management tools (xdotool, wmctrl)

## Custom Functions

### `work` - Start work on a Linear issue
```bash
work safran-lrf ct-2947
```
Automatically:
- Navigates to repository
- Creates/checks out Linear-formatted branch
- Opens Chrome with Linear issue + GitHub repo (left monitor, fullscreen)
- Opens VSCode in repo (middle monitor, fullscreen)
- Spawns Claude terminal (right monitor, left half)
- Positions work terminal (right monitor, right half)

### `review-pr` - Review a GitHub PR
```bash
review-pr 123 safran-lrf
```
Automatically:
- Checks out PR branch
- Opens VSCode in new window
- Opens PR in browser (new window)

## Secrets Management

Never commit secrets to this repository! Instead:

1. Create `~/.zshrc.local` on each machine:
```bash
# Machine-specific secrets and configuration
export LINEAR_API_KEY=your_api_key_here

# Linear CLI - Global team defaults (avoids needing .linear.toml in each repo)
export LINEAR_TEAM_ID="CT"
export LINEAR_WORKSPACE="lighthouseavionics"
export LINEAR_ISSUE_SORT="manual"
```

2. This file is automatically loaded by `.zshrc` but ignored by git

**Note**: Setting `LINEAR_TEAM_ID` and `LINEAR_WORKSPACE` as environment variables means you won't need to run `linear config` in each repository - these settings apply globally across all repos.

## Updating

To sync changes from this machine to others:

```bash
cd ~/dotfiles
git add -A
git commit -m "Update configuration"
git push
```

On other machines:
```bash
cd ~/dotfiles
git pull
source ~/.zshrc
```

## Customization

Edit files in `~/dotfiles/` and changes will automatically apply (via symlinks).

## License

MIT
