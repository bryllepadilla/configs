#!/bin/bash

#alias open-zathura='wslpath -u "$1" | sed "s/ /\\ /g; s/(/\\(/g; s/)/\\)/g; s/,/\\,/g" | xargs zathura'
#alias open-zathura="echo "$1" | xargs wslpath -u" 
#alias open-zathura="echo $0 $1| xargs -I _ wslpath -u _"
#alias open-zathura="wslpath -u $1"
#alias openzathura="echo $1 $2"

alias cd_g="sudo mount -t drvfs G: /mnt/g && cd /mnt/g/ && ls"
alias cd_b="cd /mnt/g/My\ Drive/Books_1 && ls"
alias cd_m="cd /mnt/c/Users/Brylle\ Padilla/Music/from_MediaHuman-LOCAL"
alias cd_c="cd /mnt/c/Users/Brylle\ Padilla && ls -d */"

#PS1='\[\e[36m\]${PWD#$HOME/\?:~}\[\e[0m\]\n$ '

alias ls-d="ls -d */"
alias find-z="find . -type f -print0 | xargs -0 zathura"


