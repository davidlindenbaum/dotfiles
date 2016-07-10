alias reload!='. ~/.zshrc'
alias -g gp='| grep -i'
alias -g ...='../..'
alias -g ....='../../..'

alias gitedit='e $(git status --porcelain | awk '{print $2}')'

hub_path=${$(which hub):a}
if (( $+commands[hub] ))
then
  alias git=$hub_path
fi

source $DOT/aliases.sh
