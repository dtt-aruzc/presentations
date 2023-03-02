#! /bin/bash

cd "$(dirname "$0")/.."

username=$1
sandbox=$2
dryrun=${3-""}

folder=".tmp-metadata"
textHelp="Deploy"
testlevel="RunLocalTests"
extraopts=""

if [ ! -z $sandbox ]; then
  username="$username.$sandbox"
fi

if [ ! -z $dryrun ]; then
  extraopts="--checkonly"
  textHelp="Checking deployment"
fi

scripts/lib/metadata_converter.sh $folder "package$BITBUCKET_BUILD_NUMBER"

function deploy() {
  sfdx force:mdapi:deploy \
    --deploydir $1 \
    --targetusername $2 \
    --testlevel $3 \
    $4

  sfdx force:mdapi:deploy:report -w 60 -u $2

  if [ $? -ne 0 ]; then
    echo $?
    exit 1
  fi
}

echo -e "\n[$textHelp sfdx source code]"
deploy $folder $username $testlevel $extraopts
