# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-autosuggestions
	fzf
	fzf-tab
	poetry
	docker
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# GitHub Copilot alias for bash

# Clipboard aliases using xsel
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
alias lc='colorls'
export DARKNETPATH=/home/nick/Software/darknet/

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$PATH:/home/nick/Software/mutagen"
eval "$(zoxide init zsh)"

  # FZF configuration
  export FZF_DEFAULT_OPTS="--height 80% --layout=reverse --border"
  export FZF_CTRL_T_OPTS="--preview '[[ -f {} ]] && batcat --style=numbers --color=always --line-range :500 {} || [[ -d {} ]] && eza --tree --level=2 --icons --color=always {}'"
  export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:2:wrap"

  # FZF key bindings
  [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
  [ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh

  # Modern CLI tool aliases
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -lah --icons --group-directories-first --git'
  alias lt='eza --tree --level=2 --icons'
  alias cat='bat --paging=never'


# PR Review Function - opens VSCode in new window + browser, stays in repo
# PR Review Function - simplified, opens VSCode + browser in new windows
review-pr() {
    local PR_NUMBER=$1
    local REPO_NAME=$2

    if [ -z "$PR_NUMBER" ]; then
        echo "Usage: review-pr [PR-number] [repo-name]"
        echo ""
        echo "Examples:"
        echo "  review-pr 123                # Review PR #123 in current repo"
        echo "  review-pr 123 logger         # Find 'logger' repo, review PR #123"
        return 1
    fi

    # Find repo if specified
    if [ -n "$REPO_NAME" ]; then
        local REPO_PATH=$(/usr/bin/find ~/Workspace -maxdepth 1 -type d -iname "*$REPO_NAME*" | head -1)
        if [ -z "$REPO_PATH" ]; then
            echo "Error: Could not find repo matching '$REPO_NAME' in ~/Workspace" >&2
            return 1
        fi
        cd "$REPO_PATH" || return 1
        echo "✓ Changed to $(basename "$REPO_PATH")"
    fi

    if [ ! -d .git ]; then
        echo "Error: Not in a git repository" >&2
        return 1
    fi

    echo "📋 Fetching PR #$PR_NUMBER..."
    local PR_INFO=$(gh pr view "$PR_NUMBER" --json number,title,author,headRefName,url 2>&1)
    if [ $? -ne 0 ]; then
        echo "❌ Could not fetch PR #$PR_NUMBER"
        echo "$PR_INFO"
        return 1
    fi

    local PR_TITLE=$(echo "$PR_INFO" | jq -r '.title')
    local PR_BRANCH=$(echo "$PR_INFO" | jq -r '.headRefName')
    local PR_URL=$(echo "$PR_INFO" | jq -r '.url')

    echo ""
    echo "┌─────────────────────────────────────────────────────────────"
    echo "│ 📝 PR #$PR_NUMBER: $PR_TITLE"
    echo "│ 🌿 Branch: $PR_BRANCH"
    echo "│ 🔗 $PR_URL"
    echo "└─────────────────────────────────────────────────────────────"
    echo ""

    # Checkout PR
    echo "🔄 Checking out PR branch..."
    gh pr checkout "$PR_NUMBER" 2>&1 | grep -v "Already on" || true
    echo "✓ On branch: $PR_BRANCH"
    echo ""

    # Open VSCode in new window
    echo "📂 Opening VSCode..."
    code --new-window . > /dev/null 2>&1 &

    # Open PR in browser in NEW WINDOW (not as tab)
    echo "🌐 Opening PR in new browser window..."
    sleep 0.5
    
    # Use xdg-open with specific flags to force new window
    # Most browsers respect the --new-window flag
    if command -v google-chrome &> /dev/null; then
        google-chrome --new-window "$PR_URL" > /dev/null 2>&1 &
    elif command -v firefox &> /dev/null; then
        firefox --new-window "$PR_URL" > /dev/null 2>&1 &
    else
        # Fallback to default browser
        xdg-open "$PR_URL" > /dev/null 2>&1 &
    fi

    echo ""
    echo "✨ Ready to review!"
    echo "📍 Terminal: $(pwd)"
}

# Work Function - start work on a task with Linear support and multi-monitor setup
work() {
    local REPO_NAME=$1
    local BRANCH_OR_ISSUE=$2

    # Monitor positions (from xrandr)
    # Left (HDMI-1): x=0, y=107, width=1920, height=1080
    # Middle (DP-1): x=1920, y=0, width=1920, height=1080
    # Right (DP-3): x=3840, y=0, width=1920, height=1080

    # Function to check if string looks like a Linear issue ID (e.g., CT-3617 or ct-3617)
    is_linear_issue() {
        [[ "$1" =~ ^[A-Za-z]+-[0-9]+$ ]]
    }

    # Capture current terminal window ID
    local CURRENT_TERMINAL_ID=$(xdotool getactivewindow)

    # If repo name provided, cd to it
    if [ -n "$REPO_NAME" ]; then
        local REPO_PATH=$(/usr/bin/find ~/Workspace -maxdepth 1 -type d -iname "*$REPO_NAME*" | head -1)
        if [ -z "$REPO_PATH" ]; then
            echo "Error: Could not find repo matching '$REPO_NAME' in ~/Workspace" >&2
            echo "Available repos:" >&2
            ls -1 ~/Workspace | head -10 >&2
            return 1
        fi
        cd "$REPO_PATH" || return 1
        echo "✓ Changed to $(basename "$REPO_PATH")"
    fi

    # Check if we're in a git repo
    if [ ! -d .git ]; then
        echo "Error: Not in a git repository" >&2
        return 1
    fi

    # Get GitHub repo URL
    local GITHUB_URL=$(git remote get-url origin 2>/dev/null | sed 's/\.git$//' | sed 's/git@github\.com:/https:\/\/github.com\//')

    # Variables for Linear integration
    local LINEAR_URL=""
    local ISSUE_ID=""

    # Handle branch/issue parameter
    if [ -n "$BRANCH_OR_ISSUE" ]; then
        # Check if it's a Linear issue ID
        if is_linear_issue "$BRANCH_OR_ISSUE"; then
            ISSUE_ID=$(echo "$BRANCH_OR_ISSUE" | tr '[:lower:]' '[:upper:]')
            echo "📋 Starting Linear issue: $ISSUE_ID"

            # Check if linear CLI is available
            if [ ! -f "$HOME/.deno/bin/linear" ]; then
                echo "❌ Linear CLI not found at ~/.deno/bin/linear"
                echo "💡 Make sure deno linear-cli is installed"
                return 1
            fi

            # Get Linear issue URL
            LINEAR_URL=$("$HOME/.deno/bin/linear" i url "$ISSUE_ID" 2>/dev/null | grep -E '^https://')

            # Use linear issue start to automatically create and checkout branch
            echo "🚀 Starting issue (this will create/checkout the branch)..."
            if "$HOME/.deno/bin/linear" issue start "$ISSUE_ID" 2>/dev/null; then
                echo "✓ Issue started and branch checked out"

                # Get current branch name for display
                local CURRENT_BRANCH=$(git branch --show-current)
                echo "🌿 On branch: $CURRENT_BRANCH"

                # Copy branch name to clipboard
                echo -n "$CURRENT_BRANCH" | pbcopy
                echo "✓ Branch name copied to clipboard"
            else
                echo "❌ Failed to start Linear issue"
                echo "💡 Make sure LINEAR_API_KEY is set: echo \$LINEAR_API_KEY"
                return 1
            fi
        else
            # It's a regular branch name
            local BRANCH_NAME="$BRANCH_OR_ISSUE"
            echo "🌿 Branch: $BRANCH_NAME"

            # Copy branch name to clipboard
            echo -n "$BRANCH_NAME" | pbcopy
            echo "✓ Branch name copied to clipboard"

            # Check if branch exists locally
            if git show-ref --verify --quiet refs/heads/"$BRANCH_NAME"; then
                echo "✓ Branch exists locally, checking out..."
                git checkout "$BRANCH_NAME"
            else
                # Check if branch exists remotely
                if git ls-remote --heads origin "$BRANCH_NAME" 2>/dev/null | grep -q "$BRANCH_NAME"; then
                    echo "✓ Branch exists remotely, checking out..."
                    git checkout -t "origin/$BRANCH_NAME"
                else
                    echo "✓ Creating new branch..."
                    git checkout -b "$BRANCH_NAME"
                fi
            fi
        fi
    fi

    # Store current directory for terminals
    local WORK_DIR=$(pwd)

    echo ""
    echo "🖥️  Setting up workspace across monitors..."

    # 1. Open Chrome with Linear + GitHub on LEFT monitor (fullscreen)
    if [ -n "$LINEAR_URL" ] && [ -n "$GITHUB_URL" ]; then
        echo "🌐 Opening Chrome with Linear issue and GitHub repo..."
        google-chrome --new-window "$LINEAR_URL" "$GITHUB_URL" > /dev/null 2>&1 &
        sleep 1.5

        # Find and move Chrome window to left monitor and fullscreen
        local CHROME_WIN=$(wmctrl -l | grep -i "Google Chrome" | tail -1 | awk '{print $1}')
        if [ -n "$CHROME_WIN" ]; then
            wmctrl -i -r "$CHROME_WIN" -e 0,0,107,1920,1080
            sleep 0.3
            wmctrl -i -r "$CHROME_WIN" -b add,fullscreen
        fi
    elif [ -n "$GITHUB_URL" ]; then
        echo "🌐 Opening Chrome with GitHub repo..."
        google-chrome --new-window "$GITHUB_URL" > /dev/null 2>&1 &
        sleep 1.5

        local CHROME_WIN=$(wmctrl -l | grep -i "Google Chrome" | tail -1 | awk '{print $1}')
        if [ -n "$CHROME_WIN" ]; then
            wmctrl -i -r "$CHROME_WIN" -e 0,0,107,1920,1080
            sleep 0.3
            wmctrl -i -r "$CHROME_WIN" -b add,fullscreen
        fi
    fi

    # 2. Open VSCode on MIDDLE monitor (maximized, not fullscreen so it stays movable)
    echo "📂 Opening VSCode on middle monitor..."
    code . > /dev/null 2>&1 &
    sleep 2

    local VSCODE_WIN=$(wmctrl -l | grep -E "Visual Studio Code|Code -" | tail -1 | awk '{print $1}')
    if [ -n "$VSCODE_WIN" ]; then
        wmctrl -i -r "$VSCODE_WIN" -b remove,maximized_vert,maximized_horz,fullscreen
        sleep 0.2
        wmctrl -i -r "$VSCODE_WIN" -e 0,1920,0,1920,1080
        sleep 0.3
        wmctrl -i -r "$VSCODE_WIN" -b add,maximized_vert,maximized_horz
    fi

    # 3. Open new terminal on RIGHT monitor (left half) running claude
    echo "🤖 Opening Claude terminal on right monitor (left half)..."

    # Record existing terminal windows before launching the new one
    local EXISTING_TERMS=$(xdotool search --class "gnome-terminal" 2>/dev/null | sort)

    gnome-terminal --window -- bash -c "cd '$WORK_DIR' && claude --dangerously-skip-permissions; exec bash" > /dev/null 2>&1 &
    sleep 1.5

    # Find the new terminal window by diffing against pre-existing list
    local CLAUDE_TERM=""
    for wid in $(xdotool search --class "gnome-terminal" 2>/dev/null | sort); do
        if ! echo "$EXISTING_TERMS" | grep -qx "$wid"; then
            CLAUDE_TERM="$wid"
            break
        fi
    done

    if [ -n "$CLAUDE_TERM" ]; then
        # Clear any maximized/fullscreen state, move to right monitor, then tile left
        wmctrl -i -r "$CLAUDE_TERM" -b remove,maximized_vert,maximized_horz,fullscreen
        sleep 0.2
        wmctrl -i -r "$CLAUDE_TERM" -e 0,4000,100,800,800
        sleep 0.5
        xdotool windowactivate --sync "$CLAUDE_TERM"
        sleep 0.3
        xdotool key super+Left
        sleep 0.3
    fi

    # 4. Move current terminal to RIGHT monitor (right half) using GNOME tiling
    echo "📍 Moving current terminal to right monitor (right half)..."
    wmctrl -i -r "$CURRENT_TERMINAL_ID" -b remove,maximized_vert,maximized_horz,fullscreen
    sleep 0.2
    wmctrl -i -r "$CURRENT_TERMINAL_ID" -e 0,4000,100,800,800
    sleep 0.5
    xdotool windowactivate --sync "$CURRENT_TERMINAL_ID"
    sleep 0.3
    xdotool key super+Right

    echo ""
    echo "✨ Workspace ready!"
    echo "   📍 Chrome (Linear + GitHub): Left monitor (fullscreen)"
    echo "   📍 VSCode: Middle monitor (maximized)"
    echo "   📍 Claude terminal: Right monitor (left half)"
    echo "   📍 Work terminal: Right monitor (right half)"
    echo ""
    echo "📂 Working in: $(basename $(pwd))"
}

# ============================================================================
# Modern CLI Tool Configuration
# ============================================================================

# fd (installed as fdfind on Ubuntu)
if command -v fdfind &> /dev/null; then
    alias fd='fdfind'
fi

# bat (better cat)
if command -v batcat &> /dev/null; then
    alias bat='batcat'
fi

# eza (better ls)
if command -v eza &> /dev/null; then
    alias ls='eza --icons --group-directories-first'
    alias ll='eza -lah --icons --group-directories-first --git'
    alias lt='eza --tree --level=2 --icons'
fi

# zoxide (smart cd) - MUST be at end of .zshrc
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi


# Deno
export PATH="$HOME/.deno/bin:$PATH"

# Linear API Key

# Load local secrets (not tracked in git)
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
