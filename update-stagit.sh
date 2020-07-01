#!/bin/sh

_rootdir="/srv/http"
_reporoot="/srv/git"

_repos=`ls "$_reporoot" | sed 's/.git$//'`
_repos_full=`ls "$_reporoot" | xargs printf "$_reporoot/%s\n"`

for _repo in $_repos; do
	_htmlpath="$_rootdir/$_repo"
	[ ! -e "$_htmlpath" ] && mkdir -p "$_htmlpath"
	cd "$_htmlpath"
	stagit "$_reporoot/$_repo.git"
done

cd "$_rootdir"
stagit-index `echo $_repos_full` > index.html

for _repo in $_repos; do
	[ -f style.css ] && cp style.css $_repo/
	[ -f logo.png ] && cp logo.png $_repo/
done

