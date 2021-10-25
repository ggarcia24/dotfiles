#!/usr/bin/env bash

set -e # always immediately exit upon error

# directory config. ending slashes are important!
src_dir="$HOME/Projects/"
dest_dir="$HOME/Projects_Backup/"

# run the sync
rsync --dry-run -avzr --delete --links --perms --executability --times \
  --filter=':- .gitignore' \
  --exclude='node_modules' \
  --exclude='.DS_Store' \
  --chmod='F-w' \
  "$src_dir" "$dest_dir"
