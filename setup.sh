#!/bin/bash
set -euox pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
echo "Script is running from: ${SCRIPT_DIR}"

# Check if we are logged into OpenShift

echo "Checking if user is logged into OpenShift ..."
if ! oc whoami > /dev/null 2>&1 ; then
  echo "Error: please login to Openshift first, using 'oc login' or similar."
  exit 1
fi

# Check if the project exists
PROJECT_NAME="ocp-capabilities-demo"

echo "Checking if project ${PROJECT_NAME} already exists ..."
if oc get project "${PROJECT_NAME}" > /dev/null 2>&1 ; then
  echo "Project ${PROJECT_NAME} already exists. Reusing it."
else
  echo "Creating project ${PROJECT_NAME}."
  oc new-project ocp-capabilities-demo
fi

echo "Applying manifests ..."
MANIFESTS_DIR="${SCRIPT_DIR}/manifests"
oc apply -f "${MANIFESTS_DIR}/bogohttp-deployment.yaml"
oc apply -f "${MANIFESTS_DIR}/bogohttp-hpa.yaml"
oc apply -f "${MANIFESTS_DIR}/bogohttp-route.yaml"
oc apply -f "${MANIFESTS_DIR}/manifests/bogohttp-svc.yaml"

echo "Done."
