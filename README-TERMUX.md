# Dotfiles for Termux (Android)

This guide shows how to use these dotfiles on Termux for Android.

## What Works on Termux

✅ **Fully Supported:**
- ZSH with Oh-My-Zsh
- Powerlevel10k theme with beautiful prompts
- Modern CLI tools: `bat`, `eza`, `fzf`, `ripgrep`, `fd`, `zoxide`
- ZSH plugins: autosuggestions, syntax highlighting, fzf-tab
- Git configuration
- Claude Code CLI (via npm)

❌ **Not Supported:**
- Desktop window management (`work()`, `review-pr()` full version)
- X11/GUI tools (`xdotool`, `wmctrl`, `xsel`)
- VSCode/browser launching
- Multi-monitor setup

## Quick Start

### 1. Install Git (if not already installed)
```bash
pkg install git
```

### 2. Clone this repo
```bash
cd ~
git clone https://github.com/YOUR_USERNAME/dotfiles.git
```

### 3. Run the Termux installer
```bash
cd ~/dotfiles
bash install-termux.sh
```

### 4. Change your default shell
```bash
chsh -s zsh
```

### 5. Restart Termux
Close and reopen the Termux app.

### 6. Configure Powerlevel10k
On first launch, you'll be prompted to configure p10k. If not, run:
```bash
p10k configure
```

## Fonts for Powerlevel10k

For best results with the Powerlevel10k theme icons:

### Option 1: Termux:Styling App (Recommended)
1. Install **Termux:Styling** from F-Droid or Play Store
2. Open it and select a Nerd Font (fonts with icons)
3. Recommended: **FiraCode Nerd Font** or **Hack Nerd Font**

### Option 2: Manual Font Installation
Download a Nerd Font and save it as `~/.termux/font.ttf`, then restart Termux.

## Termux-Specific Features

### Clipboard
Uses `termux-api` package for clipboard access:
```bash
# Copy to clipboard
echo "text" | pbcopy

# Paste from clipboard
pbpaste
```

### Storage Access
To access your phone's storage:
```bash
termux-setup-storage
```

Your phone storage will be available at `~/storage/`

### Notifications
Send notifications from the terminal:
```bash
termux-notification -t "Title" -c "Content"
```

## Available Commands

### Modern CLI Tools
- `ls` → `eza` with icons
- `ll` → detailed list with git status
- `lt` → tree view
- `cat` → `bat` with syntax highlighting
- `z <dir>` → smart cd with zoxide

### Git Shortcuts
- `gs` → `git status`
- `ga` → `git add`
- `gc` → `git commit`
- `gp` → `git push`
- `gl` → pretty git log
- `gd` → `git diff`

## Machine-Specific Configuration

Create `~/.zshrc.local` for secrets and machine-specific configs:

```bash
# Linear API Key
export LINEAR_API_KEY=your_api_key_here
export LINEAR_TEAM_ID="CT"
export LINEAR_WORKSPACE="lighthouseavionics"

# Other secrets or machine-specific settings
```

This file is ignored by git.

## Claude Code

Claude Code is installed via npm and runs natively on Termux (no compatibility issues):

```bash
# Start Claude
claude

# With skip permissions (for faster startup)
claude --dangerously-skip-permissions
```

**Important:** Never run `claude install` on Termux - it tries to download an incompatible binary.

To update Claude Code:
```bash
npm update -g @anthropic-ai/claude-code
```

## Troubleshooting

### ZSH not loading
Make sure you've changed your shell and restarted Termux:
```bash
chsh -s zsh
# Then close and reopen Termux
```

### Clipboard not working
Install termux-api:
```bash
pkg install termux-api
```

You also need the Termux:API app from F-Droid or Play Store.

### Icons/fonts broken
Install Termux:Styling and select a Nerd Font.

## Differences from Desktop Version

This Termux version:
- Uses `zshrc-termux` instead of the main `zshrc`
- Skips desktop-only tools during installation
- Uses Termux-specific clipboard commands
- Simplified `review-pr()` function (no VSCode/browser launching)
- No `work()` function (no window management on Android)

## Updating

To update your dotfiles:

```bash
cd ~/dotfiles
git pull
bash install-termux.sh
```

The installer will back up your existing configs before updating.
