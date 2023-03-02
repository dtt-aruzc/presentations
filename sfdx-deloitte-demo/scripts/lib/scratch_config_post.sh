#!/bin/bash

scratch_alias=${1-"new_scratch"}

gradleTask=chromeTest
if [ $SFDX_IS_TESTING ]; then
  gradleTask=remoteTest
fi

echo -e "\n[Enable login as users to admins]"
./scripts/webdriver-scripts/gradlew -b ./scripts/webdriver-scripts/build.gradle $gradleTask --tests "EnableAdminToLogInAsUsers"