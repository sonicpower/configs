source /usr/facebook/ops/rc/master.zshrc
stty stop undef

if [ -f /usr/share/scm/scm-prompt.sh ]; then
  source /usr/share/scm/scm-prompt.sh
fi

function parse_hg_branch {
  if [[ -n $(_dotfiles_scm_info) ]]; then
    echo "$(_dotfiles_scm_info)"
  fi
}
WANT_OLD_SCM_PROMPT=true

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH=/home/shiy/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
if [[ "$TERM_PROGRAM" == "nuclide" ]]; then
  echo -ne "\033]0;Terminal\007"
  ZSH_THEME="af-magic"
  DISABLE_AUTO_TITLE="true"
else
  ZSH_THEME="powerlevel9k/powerlevel9k"
fi

# set up powerlevel9k theme
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
#POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='red'
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='235'
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='245'
POWERLEVEL9K_CONTEXT_TEMPLATE="%n@%2m"
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_FOLDER_ICON='\UF07B'
POWERLEVEL9K_STATUS_OK_ICON='\UF2B0'
POWERLEVEL9K_DIR_HOME_FOREGROUND="black"
POWERLEVEL9K_DIR_HOME_BACKGROUND="green"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="black"
#POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="47"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="black"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="51"
POWERLEVEL9K_CUSTOM_PWD="echo $PWD"
POWERLEVEL9K_CUSTOM_PWD_BACKGROUND="237"
POWERLEVEL9K_CUSTOM_PWD_FOREGROUND="247"
POWERLEVEL9K_CUSTOM_MERCURIAL="parse_hg_branch"
POWERLEVEL9K_CUSTOM_MERCURIAL_BACKGROUND="22"
POWERLEVEL9K_CUSTOM_MERCURIAL_FOREGROUND="white"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context custom_mercurial custom_pwd newline dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M %Y-%m-%d}"

# enable plugins
plugins=(
  z
  zsh-syntax-highlighting
  zsh-autosuggestions
  history-substring-search
)

# load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
source $ZSH_CUSTOM/.zsh_aliases

# set up history search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey '^[[5~' history-substring-search-up
bindkey '^[[6~' history-substring-search-down

# set up zsh options
setopt COMPLETE_IN_WORD
setopt PROMPT_SUBST
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
HISTSIZE=130000 SAVEHIST=130000
HISTFILE=~/.zsh-history

# by default: export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
# we take out the slash, period, angle brackets, dash here for word tranversing.
export WORDCHARS='*?_[]~=&;!#$%^(){}'

# Colors
autoload -U colors && colors
#export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad

#hgproml
function hgproml {
  local user="%{$fg[green]%}%n"
  local at="%{$fg[yellow]%}@"
  local host="%{$fg[green]%}%m"

  export PS1="$user$at$host%{$fg[yellow]%}:\$(parse_hg_branch)%{$reset_color%} "
  PS2='> '
  PS4='+ '
}

if [[ "$TERM_PROGRAM" == "nuclide" ]]; then
  DISABLE_AUTO_TITLE="true"
  echo -ne "\033]0;Terminal\007"
fi

# Colorise the top Tabs of Iterm2 with the same color as background
# Just change the 18/26/33 wich are the rgb values
echo -e "\033]6;1;bg;red;brightness;18\a"
echo -e "\033]6;1;bg;green;brightness;26\a"
echo -e "\033]6;1;bg;blue;brightness;33\a"

export PRESTO_CLIENT_IDENTITY=$USER
