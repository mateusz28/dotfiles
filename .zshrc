# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/azajas/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="essembeh"

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

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
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
    fzf
    git
    history-substring-search
    colored-man-pages
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-z
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

if [ -z "$INSIDE_VIFM" ]; then
  PS_VIFM=""
else
  PS_VIFM="[VIFM]"
  unset INSIDE_VIFM
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f'
#export FZF_DEFAULT_OPTS="--layout=reverse --inline-info --height=80%"
if [[ ! "$PATH" == *$HOME/dotfiles/bin ]]; then
 export PATH="$PATH:$HOME/dotfiles/bin"
fi
which keychain > /dev/null && eval "$(keychain --eval $HOME/.ssh/id_rsa)"
source ~/.bash_aliases
setopt appendhistory

source $HOME/dotfiles/.ps_colors 2> /dev/null
PS_MACHINE_COLOR=${PS_MACHINE_COLOR:="10m"}
PS_USR_COLOR=${PS_USR_COLOR:="2m"}

local user="%F{$PS_USR_COLOR}%n%f@%F{$PS_MACHINE_COLOR}%m%f"

local ZSH_THEME_GIT_PROMPT_ADDED="%{$FG[103]%}✚%{$rset_color%}"
local ZSH_THEME_GIT_PROMPT_MODIFIED="%{$FG[103]%}✹%{$reset_color%}"
local ZSH_THEME_GIT_PROMPT_DELETED="%{$FG[103]%}✖%{$reset_color%}"
local ZSH_THEME_GIT_PROMPT_RENAMED="%{$FG[103]%}➜%{$reset_color%}"
local ZSH_THEME_GIT_PROMPT_UNMERGED="%{$FG[103]%}═%{$reset_color%}"
local ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$FG[103]%}✭%{$reset_color%}"

local ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[yellow]%}("
local ZSH_THEME_GIT_PROMPT_SUFFIX="$fg[yellow])%{$reset_color%}"
PROMPT='${PS_VIFM}$%{$fg_bold[green]%}%(?.%F{green}√.%F{red}✗)%{$fg_bold[white]%}[%T] ${user}:%{%B$fg[blue]%}%~%{$reset_color%b%}$(zsh_essembeh_gitstatus)%f%(!.#.$) '
RPROMPT=""

autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
zstyle ':bracketed-paste-magic' active-widgets '.self-*'
