#!/bin/sh

usage() {
	echo "nn.sh [-h] [-w PREVIRE_WINDOW_OPTS"
	exit
}

preview_window_opts="up,75%"

while getopts "hw:" opt; do
	case $opt in
		w) preview_window_opts="$OPTARG" ;;
		h) usage ;;
	esac
done
shift $(($OPTIND - 1))

[ -n "$1" ] && dir="$1" || dir="."

while : ; do
	file="$(find "$dir" -type f -not -path "$dir/.git/*" -printf "%T@ %P\n" \
		| sort -nr \
		| cut -d" " -f2- \
		| sed -e 's|/| » |g' \
		| fzf --preview-window="$preview_window_opts" \
			--preview='echo "{}" | sed -e "s| » |/|g" | xargs batwrapper --decorations=never --color always --theme gruvbox-dark')"

	[ "$?" = 130 ] && break
	file="$(echo $file | sed -e 's| » |/|g')"
	[ -n "$file" ] && nvim -c "ZenMode" "$file"
done

