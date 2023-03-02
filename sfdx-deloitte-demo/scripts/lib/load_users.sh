#!/bin/bash

scratch_alias=${1-""}

if [ -n "$scratch_alias" ]
then
  scratch_alias="-$scratch_alias"
fi

echo -e "\n[Create test user]"
scripts/lib/create_user.sh Test testuser $scratch_alias
echo -e "[Alias for test user Test$scratch_alias]"