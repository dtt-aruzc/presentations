#!/bin/bash

USER_ALIAS_PREFIX=$1;
USER_NAME=$2;
SCRATCH_ALIAS=$3;

sfdx force:user:create -f config/users/"$USER_NAME.json" -a $USER_ALIAS_PREFIX$SCRATCH_ALIAS

