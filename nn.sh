#!/bin/sh

[ -n "$1" ] && dir="$1" || dir="."

while : ; do
	file="$(find "$dir" -type f -not -path "$dir/.git/*" -printf "%T@ %P\n" \
		| sort -nr \
		| cut -d" " -f2- \
		| sed -e 's|/| » |g' \
		| fzf --preview-window=up \
			--preview='echo "{}" | sed -e "s| » |/|g" | xargs glow --style dark')"

	[ "$?" = 130 ] && break
	file="$(echo $file | sed -e 's| » |/|g')"
	[ -n "$file" ] && nvim -c "ZenMode" "$file"
done

