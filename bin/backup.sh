#!/bin/bash
#usage: backup.sh backup /mnt/g/wsl_backup
if [[ -z "$2" ]]; then
    exit 1
fi
DIR="$2"
case "$1" in
backup)
    dpkg --get-selections > $DIR/Package.list
    sudo cp -R /etc/apt/sources.list* $DIR/
    sudo apt-key exportall > $DIR/Repo.keys
    echo "" > /var/tmp/ignorelist
    echo ".dotfiles" >> /var/tmp/ignorelist
    echo ".cache" >> /var/tmp/ignorelist
    echo ".dbus" >> /var/tmp/ignorelist
    echo ".urxvt/urxvtd*" >> /var/tmp/ignorelist
    rsync -adP --exclude-from=/var/tmp/ignorelist /home/`whoami` $DIR/home/
    echo "" > /var/tmp/ignorelist
    echo "group-" >> /var/tmp/ignorelist
    echo "gshadow" >> /var/tmp/ignorelist
    echo "gshadow-" >> /var/tmp/ignorelist
    echo "passwd-" >> /var/tmp/ignorelist
    echo "shadow" >> /var/tmp/ignorelist
    echo "shadow-" >> /var/tmp/ignorelist
    echo "sudoers" >> /var/tmp/ignorelist
    echo "landscape/client.conf" >> /var/tmp/ignorelist
    echo "polkit-1/localauthority" >> /var/tmp/ignorelist
    echo "ssh_host*" >> /var/tmp/ignorelist
    echo "ssl/private" >> /var/tmp/ignorelist
    echo "sudoers.d" >> /var/tmp/ignorelist
    echo "ufw/user.rules" >> /var/tmp/ignorelist
    echo "ufw/user6.rules" >> /var/tmp/ignorelist
    echo "ufw/before6.rules" >> /var/tmp/ignorelist
    rsync -adP --exclude-from=/var/tmp/ignorelist /etc/ $DIR/etc/
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
