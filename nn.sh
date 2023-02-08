#!/bin/sh

[ -n "$1" ] && dir="$1" || dir="."

while : ; do
	file="$(find "$dir" -type f -not -path "$dir/.git/*" -printf "%T@ %P\n" \
		| sort -nr \
		| cut -d" " -f2- \
		| fzf --preview-window=up --preview "glow --style dark {}")"
	[ "$?" = 130 ] && break
	[ -n "$file" ] && nvim "$file"
done

