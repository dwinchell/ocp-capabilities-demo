#!/bin/bash
set -euo pipefail

# Check if we are logged into OpenShift
oc whoami > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Error: please login to Openshift first, using 'oc login' or similar."
  exit 1
fi

# Check if the project exists
PROJECT_NAME="ocp-capabilities-demo"
oc get project "${PROJECT_NAME}" > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "Project ${PROJECT_NAME} already exists. Reusing it."
else
  echo "Creating project ${PROJECT_NAME}."
  oc new-project ocp-capabilities-demo
fi

echo "Applying manifests ..."
oc apply -f ./manifests/manifests/bogohttp-deployment.yaml
oc apply -f ./manifests/manifests/bogohttp-hpa.yaml
oc apply -f ./manifests/manifests/bogohttp-route.yaml
oc apply -f ./manifests/manifests/bogohttp-svc.yaml

echo "Done."
