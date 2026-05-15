#!/usr/bin/env zsh

open_zathura(){
for x in "$@";do
wslpath -u "$x" | sed 's/ /\\ /g; s/(/\\(/g; s/)/\\)/g; s/,/\\,/g' | tr '\n' ' '
done
}
