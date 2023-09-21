#!/bin/bash

# Options
OWNER=${OWNER:-"danielfrg"}
LIMIT=${REPO_LIMIT:-200}
TAR_REPOS=${TAR_REPOS:-1}
ROOT_DIR=${ROOT_DIR:-"data"}
TARGET_DIR=${TARGET_DIR:-""}

# ---
file_sources="sources.txt"
file_archived="archived.txt"

declare -A kinds
kinds=( ["source"]="sources.txt" ["archive"]="archived.txt")

# Get list of repos
gh repo list --limit $LIMIT --json name $OWNER --archived | jq -r '.[]."name"' > $file_archived
gh repo list --limit $LIMIT --json name $OWNER --no-archived | jq -r '.[]."name"' > $file_sources

rm -rf $ROOT_DIR/$TARGET_DIR

for kind in "${!kinds[@]}"; do
    # Clone and tar files
    mkdir -p $ROOT_DIR/$TARGET_DIR/$OWNER/$kind
    while read repo; do
        target_dir=$ROOT_DIR/$TARGET_DIR/$OWNER/$kind/$repo
        echo "Cloning $repo to $target_dir"
        rm -rf $target_dir
        gh repo clone $OWNER/$repo $target_dir -- --quiet

        if [ $TAR_REPOS -eq 1 ]; then
            echo "Taring $repo"
            cd $ROOT_DIR/$TARGET_DIR/$OWNER/$kind
            tar -czf $repo.tar.gz $repo
            rm -rf $repo
            cd -
        fi
    done < "${kinds[$kind]}"
done
