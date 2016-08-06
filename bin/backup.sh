#!/bin/bash
#usage: backup.sh backup /mnt/g/wsl_backup
if [[ -z "$2" ]]; then
    exit 1
fi
DIR="$2"
case "$1" in
backup)
    echo "" > /var/tmp/ignorelist
    echo ".dotfiles" >> /var/tmp/ignorelist
    echo ".cache" >> /var/tmp/ignorelist
    echo ".dbus" >> /var/tmp/ignorelist
    dpkg --get-selections > $DIR/Package.list
    sudo cp -R /etc/apt/sources.list* $DIR/
    sudo apt-key exportall > $DIR/Repo.keys
    rsync -adP --exclude-from=/var/tmp/ignorelist /home/`whoami` $DIR/home/
    rsync -adP /etc/ $DIR/etc/
    ;;
restore)
    rsync -aP $DIR/etc/ /etc/
    rsync -aP $DIR/home/ /home/`whoami`
    sudo apt-key add $DIR/Repo.keys
    sudo cp -R $DIR/sources.list* /etc/apt/
    sudo apt-get update
    sudo apt-get install dselect
    sudo dpkg --set-selections < $DIR/Package.list
    sudo dselect
    ;;
esac
