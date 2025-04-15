# Pull latest dotfiles (silently) on shell start
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
if command -v config &> /dev/null; then
  config pull --quiet
fi


### Path and Environment Setup ###
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.zsh"

# PATH additions
export PATH="/home/adam/.cargo/bin:$PATH"
export PATH="/Users/adam/.local/bin:$PATH"
export PATH="$HOME/development/flutter/bin:$PATH"

# Header/Library paths
export CPATH="/opt/homebrew/include:/usr/local/include:$CPATH"
export LIBRARY_PATH="/opt/homebrew/lib:/usr/local/lib:$LIBRARY_PATH"
export C_INCLUDE_PATH="/opt/homebrew/include:$C_INCLUDE_PATH"
export TERM="xterm-256color"

### Minimal UI / UX Enhancements ###
ZSH_THEME="agnoster"  # Disable theme for faster load, or use "robbyrussell" for minimalism

# Disable Oh My Zsh splash/branding
DISABLE_AUTO_TITLE="true"
DISABLE_UPDATE_PROMPT="true"
DISABLE_MAGIC_FUNCTIONS="true"

# Update in background
zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 30  # Update every 30 days

plugins=(git history-substring-search)

# Oh My Zsh source
source $ZSH/oh-my-zsh.sh

### Fast Minimal Auto-Suggestions (Optional) ###
# Load plugins with conditional sourcing to speed up load

if [ -f "$ZSH_CUSTOM/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$ZSH_CUSTOM/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

if [ -f "$ZSH_CUSTOM/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  # Load last to avoid clobbering completion
  source "$ZSH_CUSTOM/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Suggestion: load zsh-autocomplete and vi-mode manually in interactive shells only
if [[ $- == *i* ]]; then
  [[ -f "$ZSH_CUSTOM/zsh-autocomplete/zsh-autocomplete.plugin.zsh" ]] && source "$ZSH_CUSTOM/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
  [[ -f "$ZSH_CUSTOM/zsh-vi-mode/zsh-vi-mode.plugin.zsh" ]] && source "$ZSH_CUSTOM/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
fi

# Make tab accept autosuggestion
bindkey '^I' autosuggest-accept  # ^I is the Tab key

# Use Up/Down arrow for substring search (smart history)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Optional: left/right arrow fix
bindkey '^[[C' forward-char
bindkey '^[[D' backward-char

# Tab-completion dots
COMPLETION_WAITING_DOTS="true"

### Editor ###
export EDITOR='nvim'

### Dev Tools ###
export JFLEX_DIR="$HOME/jflex-1.7.0"
export CUP_DIR="$HOME/cup"

### Conda Initialization (lazy load only when needed) ###
if command -v conda &> /dev/null; then
  __conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  elif [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
      . "/opt/anaconda3/etc/profile.d/conda.sh"
  else
      export PATH="/opt/anaconda3/bin:$PATH"
  fi
  unset __conda_setup
fi

