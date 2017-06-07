#!/bin/bash

set -euo pipefail

FILTER_QUERY=""

if [[ $# -gt 1 ]]; then
    echo "Plase provide one argument to match your cloudformation stacks"
    exit 1
fi

if [[ $# == 1 ]]; then
  FILTER_QUERY="?contains(StackName,'$1')"
fi

awscli cloudformation describe-stacks --output table --query "sort_by(Stacks,&StackName)[$FILTER_QUERY].{\"1.Name\":StackName,\"2.Status\":StackStatus,\"3.CreationTime\":CreationTime,\"4.LastUpdated\":LastUpdatedTime}"