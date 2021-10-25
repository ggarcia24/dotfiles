#! /bin/bash

# Fail on error
set -e

shopt -s nocasematch

projects_directory="~/Projects"
output_message=""

function log() {
    if [ ! -z $DEBUG ]; then
        echo $1
    fi
}

if [ ! -z $DEBUG ]; then
    set -x
fi

while getopts p: flag
do
    case "${flag}" in
        p) project=${OPTARG};;
    esac
done

code_path=$(python -c "import os; print(os.path.realpath(os.path.expanduser('$projects_directory')))")

if [[ "$project" == "all" || "$project" == "" ]]; then
    projects=$(ls -1 $code_path)
else
    projects="$project"
fi

for prj in $projects; do
    output_message=$output_message"Selected Project: $prj"$'\n'
    output_message=$output_message"Repositories updated:"$'\n'
    project_path="$code_path"/"$prj"
    cd $project_path
    for repo in $(ls -1); do
        repo_path=$project_path/"$repo"
        if [[ -d $repo_path && -d $repo_path/.git && ! $repo =~ ^zz-deprecated ]]; then
            log "Processing Repo: $repo"
            cd $repo_path
            if git rev-parse --quite --verify origin/develop > /dev/null; then
                git checkout develop --quiet
            else
                if git rev-parse --verify origin/master > /dev/null; then
                    git checkout master --quiet
                else
                    git checkout main --quiet
                fi
            fi
            git pull --quiet --prune --ff-only --progress --autostash
            if [[ $? == 0 ]]; then
                output_message=$output_message"- $repo: Done!"$'\n'
            else
                output_message=$output_message"- $repo: Failed!"$'\n'
            fi
            cd $project_path
        else
            if [[ $repo =~ ^zz-deprecated ]]; then
                output_message=$output_message"- $repo: Ignored"$'\n'
            fi
        fi
    done

    echo "$output_message"
done
