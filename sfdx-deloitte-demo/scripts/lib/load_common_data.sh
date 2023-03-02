#!/bin/bash
scratch_alias=$1

if ! [ $SFDX_IS_TESTING ]; then
  echo -e "\n[Import Test Accounts]"
  sfdx force:data:bulk:upsert -f data/common/Account.csv -s Account -i ExternalId__c -u Test-$scratch_alias
fi