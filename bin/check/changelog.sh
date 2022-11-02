#!/bin/bash
# Check that issues in CHANGELOG are up-to-to-date
set -eu

version=$(head -1 <CHANGELOG.md| cut -d" " -f1 | cut -d'[' -f2)
changelog=$(bin/release/changelog_extract.py "$version" <CHANGELOG.md| grep '^ \* ')
issues=$(bin/release/get_release_note.py "$version" 2>/dev/null | grep '^ \* ')

if [ "$changelog" != "$issues" ];  then
    echo "Diff in issues in CHANGELOG"
    diff <(echo "$changelog") <(echo "$issues")
    exit 1
fi


