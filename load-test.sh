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
  echo "Project ${PROJECT_NAME} exists."
else
  echo "Error: Project ${PROJECT_NAME} does not exist. Please run setup.sh first."
  exit 1
fi

echo "Applying manifests ..."
MANIFESTS_DIR="${SCRIPT_DIR}/manifests"
oc apply -f "${MANIFESTS_DIR}/load-test-sa.yaml"
oc apply -f "${MANIFESTS_DIR}/load-test-cm.yaml"
oc apply -f "${MANIFESTS_DIR}/load-test-pod.yaml"

echo "Load test is running!"
