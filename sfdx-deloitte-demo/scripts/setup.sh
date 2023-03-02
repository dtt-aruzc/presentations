#!/bin/bash

exit_on_error() {
    if [ $1 -ne 0 ]
    then
        echo -e $1
        exit 1
    fi
}

SCRATCH_LOGS_FOLDER=".scratch-logs"

if [ $# -lt 1 ]; then
    echo "Usage: setup.sh <scratch alias>"
    exit 1
fi

cd "$(dirname "$0")/.."

if ! test -d $SCRATCH_LOGS_FOLDER; then
    mkdir $SCRATCH_LOGS_FOLDER
fi

exit_on_error $?

scripts/lib/create_scratch.sh $1 2>&1 | tee $SCRATCH_LOGS_FOLDER/$1_1-createScratch.txt
exit_on_error $?

scripts/lib/scratch_config_pre.sh $1 2>&1 | tee $SCRATCH_LOGS_FOLDER/$1_2-scratchConfigPre.txt
exit_on_error $?

scripts/lib/push_source.sh $1 2>&1 | tee $SCRATCH_LOGS_FOLDER/$1_3-pushSource.txt

scripts/lib/scratch_config_post.sh 2>&1 | tee $SCRATCH_LOGS_FOLDER/$1_4-scratchConfigPost.txt
exit_on_error $?

scripts/lib/load_users.sh $1 2>&1 | tee $SCRATCH_LOGS_FOLDER/$1_5-loadUsers.txt
exit_on_error $?

scripts/lib/load_common_data.sh $1 2>&1 | tee $SCRATCH_LOGS_FOLDER/$1_6-loadCommonData.txt
exit_on_error $?