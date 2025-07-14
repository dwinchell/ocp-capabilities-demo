#!/bin/bash
set -xue -o pipefail

NEW_VERSION=$1

oc patch deployment/bogohttp --patch "{\"spec\": {\"template\": {\"spec\": {\"containers\": [{\"name\": \"bogohttp\", \"image\": \"quay.io/dwinchell_redhat/bogohttp:${NEW_VERSION}\"}]}}}}"

