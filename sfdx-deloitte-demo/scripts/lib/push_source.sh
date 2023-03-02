#!/bin/bash

scratch_alias=${1-"new_scratch"}

gradleTask=chromeTest
if [ $SFDX_IS_TESTING ]; then
  gradleTask=remoteTest
fi

echo -e "\n[Pushing all source to the scratch org]"
sfdx force:source:push -f -u $scratch_alias

