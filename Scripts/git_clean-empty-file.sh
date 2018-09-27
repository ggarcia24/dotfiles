#! /bin/bash -x

WORKING_DIR=$(dirname .)


if [[ -d $WORKING_DIR/.git ]]; then
    for FILE in $(git status --porcelain | grep "^ M" | sed 's/ M //'); do
        if [[ -z $(git diff $FILE) ]]; then
            git checkout -- $FILE
        fi
    done
else
    echo "This is not a git reposotiry"
fi
