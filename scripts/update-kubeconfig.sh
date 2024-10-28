#!/bin/bash
response="$(aws eks list-clusters --region eu-west-2 --output text | grep -i jide-cluster 2>&1)" 
if [[ $? -eq 0 ]]; then
    echo "Success: jide-cluster exist"
    aws eks --region eu-west-2 update-kubeconfig --name jide-cluster && export KUBE_CONFIG_PATH=~/.kube/config

else
    echo "Error: jide-cluster does not exist"
fi