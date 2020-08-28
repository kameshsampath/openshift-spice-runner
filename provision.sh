#!/usr/bin/env bash

set -e

_CURR_DIR="$( cd "$(dirname "$0")" ; pwd -P )"

RUNNER_PLAYBOOK=${1:-playbook.yml}

docker run -it  \
 -v "${_CURR_DIR}/env":/runner/env:z \
 -v "${_CURR_DIR}/project":/runner/project:z \
 -v "${_CURR_DIR}/inventory":/runner/inventory:z \
 -e "RUNNER_PLAYBOOK=$RUNNER_PLAYBOOK" \
  quay.io/rhdevelopers/ansible-runner-extras /runner/project/run.sh