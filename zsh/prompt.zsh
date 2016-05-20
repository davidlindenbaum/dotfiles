autoload colors && colors

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi
green="%{$fg_bold[green]%}"
red="%{$fg_bold[red]%}"
magenta="%{$fg_bold[magenta]%}"
cyan="%{$fg_bold[cyan]%}"
reset="%{$reset_color%}"

git_prompt_info() {
    ref=$($git symbolic-ref HEAD 2>/dev/null)
    if [[ $? -eq 0 ]]; then
        branch=${ref#refs/heads/}
        dirty=$($git diff --quiet && echo $green || echo $red)
        ahead_num=$($git rev-list @{u}.. | wc -l)
        ahead_text="$reset"
        if [[ $ahead_num > 0 ]] ahead_text="$magenta +$ahead_num$reset"
        echo " $dirty$branch$ahead_text"
    fi
}

gitprompt() {
    export GIT_PROMPT=$((1-$GIT_PROMPT))
    if (( $GIT_PROMPT )); then
        export PROMPT=$'$green%n$reset:$cyan%5~$($git status -b --porcelain 2>/dev/null | parse_git) › '
    else
        export PROMPT=$'$green%n$reset:$cyan%5~$reset › '
    fi
}

#if [[ $(uname -o) == "Cygwin" ]]
#then
#    export GIT_PROMPT=1
#else
#    export GIT_PROMPT=0
#fi
#gitprompt
source $ZSH/.shell_prompt.sh

precmd() {
  title "zsh" "%m" "%55<...<%~"
}
