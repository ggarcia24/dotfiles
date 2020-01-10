#! /bin/bash

function log() {
    if [ ! -z $DEBUG ]; then
        echo $1
    fi
}

if [ ! -z $DEBUG ]; then
    set -x
fi

output_message="Repositories updated:"$'\n'

code_path=$(python -c "import os; print(os.path.realpath(os.path.expanduser('~/code')))")

cd $code_path
for repo in $(ls -1 $code_path); do
    if [ -d "$code_path/$repo" -a -d "$code_path/$repo/.git" ]; then
        log "Processing Repo: $repo"
        cd $repo
        command_output=$(git pull --ff-only)
        if [[ $? == 0 ]]; then
            output_message=$output_message"- $repo: Done!"$'\n'
        else
            output_message=$output_message"- $repo: Failed!"$'\n'
        fi
        cd ~/code
    fi
done
        
echo "$output_message"
