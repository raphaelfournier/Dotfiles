# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#export MAILPATH="$HOME/Mail/CNAM/INBOX/new"

export FZF_MARKER_CONF_DIR=~/.config/marker
export FZF_MARKER_COMMAND_COLOR='\x1b[38;5;255m'
export FZF_MARKER_COMMENT_COLOR='\x1b[38;5;8m'
export FZF_MARKER_MAIN_KEY='\C-@'
export FZF_MARKER_PLACEHOLDER_KEY='\C-v'

# Path to your oh-my-zsh installation.
  export ZSH="/home/raph/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="rfs"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  #git fzf-marker jump invoke
  git jump invoke
)

source $ZSH/oh-my-zsh.sh
source /home/raph/.bash_aliases
source /home/raph/.bash_functions
source /home/raph/.zsh_functions
source /home/raph/.fzf_functions
source /home/raph/.zsh_aliases

# https://github.com/urbainvaes/fzf-marks
source /usr/share/fzf-marks/fzf-marks.zsh
source /home/raph/.scripts/zsh-syntax-highlighting-filetypes/zsh-syntax-highlighting-filetypes.zsh
#source /usr/share/cdargs/cdargs-bash.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=fr_FR.UTF-8

export DISABLE_AUTO_TITLE=true

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export JAVA_HOME="/usr/lib/jvm/java-8-openjdk/"
export QUOTING_STYLE=literal
export QT_QPA_PLATFORMTHEME="qt5ct"
source $HOME/.shell_path
#
#export PATH="$HOME/.dynamic-colors/bin:$PATH"

export HISTSIZE=10000
export EDITOR="vim"
export MANPAGER=most
export XDG_CONFIG_HOME="/home/raph/.config"
export XDG_DATA_HOME="/home/raph/.local/share"
export MUTTJUMP_INDEXER=mu
export GPG_TTY=`tty`
export BROWSER="firefox"
export MAIL='~/Mail'

PERL5LIB="/home/raph/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/raph/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/raph/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/raph/perl5"; export PERL_MM_OPT;

#export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --preview-window right:50% --preview "[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -500"'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --preview-window right:50% --preview "bat --color=always --style=header,grid --line-range :300 {}"'


source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# Options to fzf command
export FZF_COMPLETION_OPTS='+c -x'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
#(\cat ~/.cache/wal/sequences &)

eval `dircolors ~/.ls_colors` 

export MARKER_KEY_MARK='\C-b' # https://github.com/pindexis/marker/blob/master/README.md
[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"

autoload -Uz compinit
compinit
# Completion for kitty
#kitty + complete setup zsh | source /dev/stdin

bindkey " " magic-space # do history expansion on space

#source ~/.oh-my-zsh/invoke/zsh
source ~/.passwordstore-variables

# Base16 Shell
#BASE16_SHELL="$HOME/.base16-manager/chriskempson/base16-shell/"
#[ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && eval "$("$BASE16_SHELL/profile_helper.sh")"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/raph/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/raph/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/raph/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/raph/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

