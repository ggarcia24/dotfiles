#! /bin/bash

# Fail on error
set -e

shopt -s nocasematch

projects_directory="$HOME/Projects"

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

code_path=$(realpath $projects_directory)

if [[ "$project" == "all" || "$project" == "" ]]; then
    projects=$(ls -1 $code_path)
else
    projects="$project"
fi

for prj in $projects; do
    echo "Selected Project: $prj"
    project_path="$code_path"/"$prj"
    cd $project_path
    # Get all of the git repositories, adjust maxdepth
    project_repos=$(find $project_path -name ".git" -type d -maxdepth 3 | sort)
    for repo in $project_repos; do
        repo_path=$(dirname $repo)
        repo_name=$(basename $repo_path)
        echo "- $repo_name"
        if [[ ! $repo_name =~ ^zz-deprecated ]]; then
            cd $repo_path
            remote_name=$(git remote)
            # If the repository has a remote
            if [[ ! -z $remote_name ]]; then
                # Fetch remote ref changes
                git fetch --all --prune --quiet
                # Try to get the default branch name (develop, else master, else main)
                main_branch=$(git remote show $remote_name | sed -n '/HEAD branch/s/.*: //p')
                # Checkout default branch and pull the repository for changes
                if git checkout $main_branch --quiet && git pull --quiet --prune --ff-only --progress --autostash > /dev/null 2>&1; then
                    echo "Pull complete!"
                else
                    echo "Pull failed!"
                fi
            else
                echo "No remote repo!"
            fi
            cd $project_path
        else
            echo "Deprecated"
        fi
    done
done
