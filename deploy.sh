#!/bin/bash

# BRANCH_NAME is a default variable set by Jenkins
#    on Jenkins agents it's equal to the branch that's being built

# -e option will make sure that script stops on first error
# -x option will show you everything that script is running to the output, helpful for troubleshooting
set -ex

export AWS_DEFAULT_REGION=us-east-1

# define current stage based on branch name
if [[ $BRANCH_NAME == feature-* ]]
then
    current_stage=dev
elif [[ $BRANCH_NAME == main ]]
then
    current_stage=prod
elif [[ $BRANCH_NAME == stage ]]
then
    current_stage=staging
else
    echo "Unknown branch or branch name: $BRANCH_NAME"
    exit 1
fi

ansible-playbook redis_deploy.yaml --extra-vars @./vars/${current_stage}.yaml