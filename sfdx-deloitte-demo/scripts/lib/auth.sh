#! /bin/bash

cd "$(dirname "$0")/../.."

username=$1
clientId=$2
sandbox=$3

url="https://login.salesforce.com"

if [ ! -z "$sandbox" ]; then
  url="https://test.salesforce.com"
  username="$username.$sandbox"
fi


echo -e "\n[Authenticating]"

sfdx force:auth:jwt:grant \
  -r $url \
  -i $clientId \
  -f "config/keys/dev.key" \
  -u $username
