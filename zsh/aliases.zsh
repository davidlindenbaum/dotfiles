alias reload!='. ~/.zshrc'
alias -g gp='| grep -i'
alias -g ...='../..'
alias -g ....='../../..'

hub_path=${$(which hub):a}
if (( $+commands[hub] ))
then
  alias git=$hub_path
fi
