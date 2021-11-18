#! /bin/bash

# Fail on error
set -e

shopt -s nocasematch

projects_directory="~/Projects"

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
    echo "Selected Project: $prj"
    project_path="$code_path"/"$prj"
    cd $project_path
    for repo in $(ls -1); do
        repo_path=$project_path/"$repo"
        if [[ -d $repo_path && -d $repo_path/.git && ! $repo =~ ^zz-deprecated ]]; then
            cd $repo_path
            # If the repository has a remote
            if [[ ! -z $(git remote) ]]; then
                # Checkout the correct branch (develop, else master, else main_
                if git rev-parse --quiet --verify origin/develop > /dev/null; then
                    git checkout develop --quiet
                else
                    if git rev-parse --quiet --verify origin/master > /dev/null; then
                        git checkout master --quiet
                    else
                        git checkout main --quiet
                    fi
                fi
                # Pull the repository for changes
                if git pull --quiet --prune --ff-only --progress --autostash; then
                    echo "- $repo: Pull complete!"
                else
                    echo "- $repo: Pull failed!"
                fi
            else
                echo "- $repo: Ignored: No remote repo!"
            fi
            cd $project_path
        else
            if [[ $repo =~ ^zz-deprecated ]]; then
                echo "- $repo: Deprecated"
            fi
        fi
    done

    echo "$output_message"
done
