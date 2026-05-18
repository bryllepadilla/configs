#!/usr/bin/zsh
#EVERY saved abbr, REFER BACK to ~/.config/zsh-abbr/user-abbreviations
#COMMENT each new abbr, SOURCE, REFER BACK to ~/.config/zsh-abbr/user-abbreviations

#TERMINAL IS FOR emacsclient only TO AVOID clashing of tabs, buffers & frames that errors desktop-save
#alias emacsclient1="emacs --daemon && emacsclient -nw"
alias emacskill="emacsclient -e '(kill-emacs)'"
alias emacsc="emacsclient -nw"

#abbr sed_="sed -i '1s/^/%/' <>"
#alias ls="lsd -hF --group-dirs first"
alias ls="lsd -ahF --group-dirs first --color=never"
alias zjls="zellij list-sessions"
alias zjka="zellij kill-all-sessions"
alias zjda="zellij delete-all-sessions"
alias zjd="zellij delete-session "
alias zja="zellij attach "                           #launch with KNOWN NAME
alias zjn="zellij -s "
#alias zellij="zellij -s"                             #CREATE from scratch with NEW NAME
#alias emacs_client="emacsclient -nw -e '(switch-to-buffer "*scratch*")'"

alias sioyek="/mnt/c/Users/Brylle\ Padilla/Downloads/sioyek-release-windows-portable/sioyek-release-windows/sioyek.exe"

alias lssf="sf org list"
alias sfupdate="npm update --global @salesforce/cli"
#abbr -U soql_='sf data query --query "%" --target-org VSCodePlayground'

alias fzfp="fzf --preview='less {}'"
#abbr -U fzf_='ls < cd ~/%**'
#seq 3 | xargs -I {} touch {}.txt

#abbr -U zathura_='open_zathura % | xargs zathura'

alias mv="mv -i"
