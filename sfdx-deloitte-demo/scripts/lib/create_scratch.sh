#!/bin/bash

scratch_alias=${1-"new_scratch"}
scratch_config=${2-"config/project-scratch-def.json"}
scratch_duration=${3-30}

if [ $SFDX_IS_TESTING ]; then
  scratch_duration=1
fi

echo -e "\n[Creating scratch org $scratch_alias]"
sfdx force:org:create -s -f $scratch_config -d $scratch_duration -a $scratch_alias