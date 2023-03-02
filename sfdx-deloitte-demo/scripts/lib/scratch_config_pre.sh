#!/bin/bash

scratch_alias=${1-"new_scratch"}

gradleTask=chromeTest
if [ $SFDX_IS_TESTING ]; then
  gradleTask=remoteTest
fi

echo -e "\n[Enabling account history tracking]"
sfdx force:mdapi:deploy -u $scratch_alias -d metadata/account-history-tracking -w 15