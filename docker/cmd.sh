#!/bin/bash
set -euxo pipefail

export ROOT_DIR=/data

echo "Authenticating with token"
echo $GH_TOKEN |  gh auth login --with-token
echo "Authentication done"

bash /usr/local/bin/backup.sh
