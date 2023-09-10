#!/bin/bash

OWNER=${OWNER:-"danielfrg"}
LIMIT=${REPO_LIMIT:-200}
TARGET_DIR=${TARGET_DIR:-"archive"}
TAR=${TAR:-1}

file="repos.txt"

gh repo list --limit $LIMIT --json name $OWNER | jq -r '.[]."name"' > $file

mkdir -p archive
while read repo; do
    echo "Cloning $repo"
    rm -rf $TARGET_DIR/$repo
    gh repo clone $OWNER/$repo $TARGET_DIR/$repo -- --quiet

    if [ $TAR -eq 1 ]; then
        echo "Taring $repo"
        cd $TARGET_DIR
        tar -czf $repo.tar.gz $repo
        rm -rf $repo
        cd ..
    fi
done < "$file"
