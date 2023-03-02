#!/bin/bash

TARGET_USERNAME=$1
TARGET_CLIENT_ID=$2
PROD_CLIENT_ID=$3
BRANCH_TAG=$4
TARGET_INSTANCE=$5

TARGET_ALIAS="develop"
TEST_RUN_WAIT=15
TEST_RUN_FORMAT="human"
TEST_RUN_LEVEL="RunLocalTests"

cd "$(dirname "$0")/.."
if [[ "$TARGET_INSTANCE" == "prod" ]]; then 
    TARGET_CLIENT_ID=$PROD_CLIENT_ID
fi

echo -e "\n[Testing deploy]"

if [[ "$TARGET_INSTANCE" == "prod" ]]; then
    TARGET_INSTANCE=""
    TARGET_ALIAS=$TARGET_USERNAME
else 
    TARGET_ALIAS=$TARGET_USERNAME."$TARGET_INSTANCE"
fi

scripts/lib/auth.sh $TARGET_USERNAME $TARGET_CLIENT_ID $TARGET_INSTANCE
scripts/deploy.sh $TARGET_USERNAME "$TARGET_INSTANCE" true

if [ $? -eq 0 ]; then
    echo -e "\n[Tests ran successfully]"
    exit 0
else
    echo -e "\n[Error running tests]"
    exit 1
fi
