#!/bin/bash

# Options
OWNER=${OWNER:-"danielfrg"}
LIMIT=${REPO_LIMIT:-200}
TAR_REPOS=${TAR_REPOS:-1}
ROOT_DIR=${ROOT_DIR:-"data"}
TARGET_DIR=${TARGET_DIR:-""}

# Internal
file="repos.txt"

# Get list of repos
gh repo list --limit $LIMIT --json name $OWNER | jq -r '.[]."name"' > $file

# Clone and Tar
mkdir -p $ROOT_DIR/$TARGET_DIR/$OWNER
while read repo; do
    echo "Cloning $repo to $ROOT_DIR/$TARGET_DIR/$OWNER/$repo"
    rm -rf $ROOT_DIR/$TARGET_DIR/$OWNER/$repo
    gh repo clone $OWNER/$repo $ROOT_DIR/$TARGET_DIR/$OWNER/$repo -- --quiet

    if [ $TAR_REPOS -eq 1 ]; then
        echo "Taring $repo"
        cd $ROOT_DIR/$TARGET_DIR/$OWNER
        tar -czf $repo.tar.gz $repo
        rm -rf $repo
        cd -
    fi
done < "$file"
