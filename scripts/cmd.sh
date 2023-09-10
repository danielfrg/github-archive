#!/bin/bash
# Script used by docker

export TARGET_DIR=/data

echo "Authenticating with token"
echo $GH_TOKEN |  gh auth login --with-token
echo "Authentication done"

bash /usr/local/bin/backup.sh
