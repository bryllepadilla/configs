#!/usr/bin/env zsh

alias cd_g="sudo mount -t drvfs G: /mnt/g && cd /mnt/g/My\ Drive/Books_1/1_Books_04 && ls"
alias cd_b="cd /mnt/g/My\ Drive/Books_1 && ls"
alias cd_m="cd /mnt/c/Users/Brylle\ Padilla/Music/from_MediaHuman-LOCAL"
alias cd_c="cd /mnt/c/Users/Brylle\ Padilla && ls -d */"

#PS1='\[\e[36m\]${PWD#$HOME/\?:~}\[\e[0m\]\n$ '

#alias ls-d="ls -d */"
alias find-z="find . -type f -print0 | xargs -0 zathura"


