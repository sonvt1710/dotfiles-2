# shellcheck disable=SC2206,SC2128,SC2296,SC2148,SC1090,SC1091,SC2034
# Usage: toggle fold in Vim with 'za'. 'zR' to open all folds, 'zM' to close
# Bash: try importing bashrc, but stop here if not found {{{

if [[ -f "$HOME/.bashrc" ]]; then
  source "$HOME/.bashrc"
else
  echo "$HOME/.bashrc not found, zsh loading default shell"
  return 0
fi

# }}}
# Environment: zsh overrides {{{

export HISTFILE=~/.zsh_history

# }}}
# Aliases: zsh overrides {{{

alias z='nvim ~/config/dotfiles/.zshrc'

# }}}
# Z-shell: plugins {{{

if [ -f "$HOME/.zplug/init.zsh" ]; then
  source "$HOME/.zplug/init.zsh"

  # BEGIN: List plugins
  zplug "zplug/zplug", hook-build: "zplug --self-manage"
  zplug "greymd/docker-zsh-completion", as:plugin
  zplug "zsh-users/zsh-completions", as:plugin
  zplug "zdharma/fast-syntax-highlighting", as:plugin
  zplug "spaceship-prompt/spaceship-prompt", \
    use:spaceship.zsh, \
    from:github, \
    as:theme
  # END: List plugins

  # Install plugins if there are plugins that have not been installed
  if ! zplug check --verbose; then
      printf "Install? [y/N]: "
      if read -rq; then
          echo; zplug install
      fi
  fi

  # Then, source plugins and add commands to $PATH
  zplug load
else
  echo "zplug not installed, so no plugins available"
fi

# }}}
# Z-shell: options {{{

#######################################################################
# Set options
#######################################################################

# enable functions to operate in PS1
setopt PROMPT_SUBST

# list available directories automatically
setopt AUTO_LIST
setopt LIST_AMBIGUOUS
setopt LIST_BEEP

# completions
setopt COMPLETE_ALIASES

# automatically CD without typing cd
setopt AUTOCD

# Dealing with history
setopt HIST_IGNORE_SPACE
setopt APPENDHISTORY
setopt SHAREHISTORY
setopt INCAPPENDHISTORY

#######################################################################
# Unset options
#######################################################################

# do not automatically complete
unsetopt MENU_COMPLETE

# do not automatically remove the slash
unsetopt AUTO_REMOVE_SLASH

#######################################################################
# Expected parameters
#######################################################################
export PERIOD=1
export LISTMAX=0

# }}}
# Z-shell: misc autoloads {{{

# Enables zshell calculator: type with zcalc
autoload -Uz zcalc

# }}}
# Z-shell: hook functions {{{

# Executed before each prompt. Note that precommand functions are not
# re-executed simply because the command line is redrawn, as happens, for
# example, when a notification about an exiting job is displayed.
function precmd() {
  eval "$PROMPT_COMMAND"
}

# }}}
# Z-shell: auto completion {{{

fpath=(${ASDF_DIR}/completions $fpath)
autoload -U compinit && compinit
autoload -U +X bashcompinit && bashcompinit
zstyle ':completion:*:*:git:*' script /usr/local/etc/bash_completion.d/git-completion.bash

# CURRENT STATE: does not select any sort of searching
# searching was too annoying and I didn't really use it
# If you want it back, use "search-backward" as an option
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

# Fuzzy completion
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-A-Z}={A-Z\_a-z}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-A-Z}={A-Z\_a-z}' \
  'r:|?=** m:{a-z\-A-Z}={A-Z\_a-z}'
fpath=(/usr/local/share/zsh-completions $fpath)
zmodload -i zsh/complist

# Add autocompletion path
fpath+=(~/.zfunc)

# Add autocompletion for aws-cli v2
if command -v aws > /dev/null; then
  complete -C aws_completer aws
fi

# Add autocompletion for pipx
if command -v pipx > /dev/null; then
  eval "$(register-python-argcomplete pipx)"
fi

# }}}
# Z-shell: key remapping {{{

# emacs
bindkey -e

# NOTE: about menu-complete
# '^d' - list options without selecting any of them
# '^i' - synonym to TAB; tap twice to get into menu complete
# '^o' - choose selection and execute
# '^m' - choose selection but do NOT execute AND leave all modes in menu-select
#         useful to get out of both select and search-backward
# '^z' - stop interactive tab-complete mode and go back to regular selection

# navigate menu with vi keys "hjkl"
bindkey -M menuselect '^j' menu-complete
bindkey -M menuselect '^k' reverse-menu-complete
bindkey -M menuselect '^h' backward-char
bindkey -M menuselect '^l' forward-char

# delete function characters to include
# Omitted: /=
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# }}}
# Z-shell: shell prompt config {{{

# https://github.com/denysdovhan/spaceship-prompt/blob/master/docs/Options.md

SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  host          # Hostname section
  dir           # Current directory section
  venv          # virtualenv section
  git           # Git section (git_branch + git_status)
  line_sep      # Line break
  char          # Prompt character
)

SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL='$ '
SPACESHIP_DIR_PREFIX=
SPACESHIP_DIR_TRUNC=0
SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_HOST_COLOR=yellow
SPACESHIP_HOST_PREFIX=@
SPACESHIP_HOST_SHOW=true
SPACESHIP_USER_COLOR=yellow
SPACESHIP_USER_SHOW=true
SPACESHIP_USER_SUFFIX=
SPACESHIP_VENV_PREFIX='('
SPACESHIP_VENV_SUFFIX=') '
SPACESHIP_VENV_GENERIC_NAMES=()
SPACESHIP_CHAR_COLOR_SUCCESS=green
SPACESHIP_CHAR_COLOR_FAILURE=green
SPACESHIP_NODE_SHOW=false

# }}}
# Z-shell: compdef {{{

# helpers

function _vplug_completion() {
  _directories -W "$HOME/.config/nvim/pack/packager/start"
}

function _asdf_complete_plugins() {
  local -a subcmds
  # shellcheck disable=2034,2207
  subcmds=($(asdf plugin-list | tr '\n' ' '))
  _describe 'List installed plugins for zsh completion' subcmds
}

# definitions

compdef _vim f
compdef _vim fn
compdef _dict_words def
compdef _dict_words syn
compdef _directories d
compdef "_files -W $GITIGNORE_DIR/" gitignore
compdef _vplug_completion vplug
compdef _man m
compdef _command ve
compdef _asdf_complete_plugins asdfl

# }}}
# Runtime: executed commands for interactive shell {{{

# Note: .zshrc is only read by zsh when the shell is interactive

# shellcheck disable=2202,2086,1087
if [ $commands[direnv] ]; then
  eval "$(direnv hook zsh)"
fi

# }}}
