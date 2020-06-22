#!/bin/bash

CMD=$(realpath -s ${BASH_SOURCE[0]})
NAME=$(basename $CMD)
git_root=$(git rev-parse --show-toplevel) || exit $?

# link to pre-commit and exit if it was called via './init-hooks.sh'
if [[ "$NAME" != "pre-commit" ]]; then
    ln -s $CMD $git_root/.git/hooks/pre-commit
    exit $?
fi

# otherwise, we're running as a part of the actual hook, so render the site and add it
./render.py
git add site/


