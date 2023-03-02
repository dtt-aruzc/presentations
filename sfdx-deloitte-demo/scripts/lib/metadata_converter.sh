#!/bin/bash

cd "$(dirname "$0")/../.."


outputdir=${1-".tmp-metadata"}
packagename=${2-"pck"}


sfdx force:source:convert -d $outputdir -n $packagename


