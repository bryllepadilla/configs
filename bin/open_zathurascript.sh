#!/bin/bash

open_zathura(){
for x in "$@";do
wslpath -u "$x" | sed 's/ /\\ /g; s/(/\\(/g; s/)/\\)/g; s/,/\\,/g' | tr '\n' ' '
done
}

#xargs -I "{}" zathura "{}"
# CORRECT
#for x in "$@";do
#wslpath -u "$x" | sed 's/ /\\ /g; s/(/\\(/g; s/)/\\)/g; s/,/\\,/g' | tr '\n' ' ' <--- variable somewhere
#done
#zathura varaible here <---

#wslpath -u "$x" | sed 's/ /\\ /g; s/(/\\(/g; s/)/\\)/g; s/,/\\,/g' | awk -v ors=' ' '1' | sed 's/ $//' | xargs 
#sed 's/ /\\ /g; s/(/\\(/g; s/)/\\)/g; s/,/\\,/g' | paste -s -d ' ' |


#open_zathura() { forging <- * and # isbetter than g*
#	for x in $1 $2
#	do echo $x
#	done
#}

#open_zathura() {
#m=$#
#for ((i=1; i<=m; i++));do
#
#echo $i
#done
#}

# open_zathura() {
# 	local max_files=3
# 	local -a files
# 
# 	if [[ $# -eq 0 ]]; then
# 		echo "Usage: open-zathura [file1] [file2] [file3]"
# 		return 1
# 	fi
# 	
# 	for ((i=1; i<=max_files && i<=$#; i++)); do
#         	if [[ -n "${!i}" ]]; then
#             		# Process each argument with wslpath -u and sed
#             		converted=$(echo "${!i}" | xargs -I {} wslpath -u "{}" | sed 's/ /\\ /g; s/(/\\(/g; s/)/\\)/g; s/,/\\,/g')
#             		files+=("$converted")
#         	fi
#     	done
#     	# Pass converted files to zathura
#     	if [[ ${#files[@]} -gt 0 ]]; then
#         	zathura "${files[@]}" 2>/dev/null
#     	else
#         	echo "No valid files provided"
#         	return 1
#     	fi
# }
