############################################################################
#                                   PATH                                   #
############################################################################
## Enable brew evaluations
export PATH=/opt/homebrew/bin/:$PATH

## Add homebrew installs to path
export PATH="$(brew --prefix)/sbin:$PATH"
export PATH="$(brew --prefix)/bin:$PATH"
export PATH="$(brew --prefix)/opt/openssl/bin:$PATH"

############################################################################
#                             VISUAL & PROMPT                              #
############################################################################
## oh-my-posh
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
fi

## add support for more color
export CLICOLOR=1

## autocomplete
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

## add shell history sharing
setopt share_history

############################################################################
#                                 ALIASES                                  #
############################################################################
# make vim use neovim
alias vim=nvim
alias k=kubectl

############################################################################
#                                  FEDEX                                   #
############################################################################
## cloudops-cli
export PATH="$PATH:/Users/taylor.font/cloudops-cli/current"
alias cloudops='cloudops-cli'

## cf-cli login
export PATH="$PATH:/Users/taylor.font/cf-cli-wrapper"

############################################################################
#                                   JAVA                                   #
############################################################################
# set JAVA_HOME as JDK17
JAVA_VERSION=17
export JAVA_HOME="$(brew --prefix)/opt/openjdk@${JAVA_VERSION}"

############################################################################
#                                  PYENV                                   #
############################################################################
# Load pyenv automatically by appending
# the following to
# ~/.zprofile (for login shells)
# and ~/.zshrc (for interactive shells) :
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

