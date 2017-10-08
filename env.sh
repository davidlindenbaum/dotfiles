export PROJECTS=~/code
export EDITOR='vim'
export PATH="$DOT/bin:$HOME/bin:/usr/sbin:$PATH"

export LANG=en_US.UTF-8

export LESS_TERMCAP_md=$'\e[1;36m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;40;92m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

if [[ -a /usr/share/source-highlight/src-hilite-lesspipe.sh ]]
then
    export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
    export LESS=' -R '
fi

