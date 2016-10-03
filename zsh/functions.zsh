dict() {
    # Lookup regex in dict
    grep --color=always "$@" /usr/share/dict/words
}

fgrep() {
    # returns only unique filenames
    grep -R "$@" * | sed 's/:/ /g' | awk '{ print $1 }' | sort | uniq
}
psgrep() {
    # Find all processes that match, list whole ps line
    if [ ! -z $1 ] ; then
        echo "Grepping for processes matching $1..."
        ps aux | grep $1 | grep -v grep
    else
        echo "!! Need name to grep for"
    fi
}

killit() {
    # Kills any process that matches a regexp passed to it
    ps aux | grep -v "grep" | grep "$@" | awk '{print $2}' | xargs sudo kill
}

# mkdir and cd to it
mcd () {
    mkdir "$@" && cd "$@"
}

pycalc() {
  python -c "print $@"
}

ips() {
  ipconfig | grep '^ *IPv4' | awk '{ print $16 }'
}

shell () {
  ps -p $$ | awk '{if (NR>1) print $8}'
}
