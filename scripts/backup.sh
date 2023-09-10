#!/bin/bash

# Options
OWNER=${OWNER:-"danielfrg"}
LIMIT=${REPO_LIMIT:-200}
TAR_REPOS=${TAR_REPOS:-1}
TARGET_DIR=${TARGET_DIR:-"data"}

# Internal
file="repos.txt"

# Get list of repos
gh repo list --limit $LIMIT --json name $OWNER | jq -r '.[]."name"' > $file

# Clone and Tar
mkdir -p $TARGET_DIR
while read repo; do
    echo "Cloning $repo"
    rm -rf $TARGET_DIR/$repo
    gh repo clone $OWNER/$repo $TARGET_DIR/$repo -- --quiet

    if [ $TAR_REPOS -eq 1 ]; then
        echo "Taring $repo"
        cd $TARGET_DIR
        tar -czf $repo.tar.gz $repo
        rm -rf $repo
        cd ..
    fi
done < "$file"
