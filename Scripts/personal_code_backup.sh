#!/usr/bin/env bash

set -e # always immediately exit upon error

# directory config. ending slashes are important! (line 12)
src_dir="$HOME/Dropbox_Projects"
dest_dir="$HOME/Dropbox/Projects"

for dir in $(ls -1 $src_dir); do
  for project in $(ls -1 $src_dir/$dir); do
    # run the sync
    rsync -avzr --delete --links --perms --executability --times \
      --filter=':- .gitignore' \
      --exclude='node_modules' \
      --exclude='.DS_Store' \
      --chmod='F-w' \
      "$src_dir/$dir/$project/" "$dest_dir/$dir/$project"
  done
done

