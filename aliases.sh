alias grep='grep --color -InH'                # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour

alias l='ls -h --color=tty'
alias ls='ls -h --color=tty'                  # classify files in colour
alias la='ls -Ah --color=tty'
alias ll='ls -lh --color=tty'

alias sml='rlwrap -c -f /usr/share/autocomplete sml'
alias clojure='rlwrap -c java -jar ~/clojure-1.6.0.jar'

alias servethis="python -c 'import SimpleHTTPServer; SimpleHTTPServer.test()'"

alias exip='curl ipecho.net/plain ; echo'

alias runx='run xwin -multiwindow -clipboard'

alias ga='git add'
alias gl='git pull --prune'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'
alias gd='git diff | vim -'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gcb='git copy-branch-name'
alias gb='git branch'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias gr='git stash && git svn rebase && git svn dcommit && git stash pop' # git refresh
alias gv='git --version'

alias r='ranger --choosedir=/tmp/rangerdir; LASTDIR=`cat /tmp/rangerdir`; cd "$LASTDIR"'
