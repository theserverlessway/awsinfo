#!/bin/bash

set -euo pipefail

QUERY="logGroups[].[logGroupName]"

if [[ $# -gt 1 ]]; then
    echo "Plase provide only one argument to match"
    exit 1
fi

if [[ $# == 1 ]]; then
  QUERY="logGroups[?contains(logGroupName,'$1')].[logGroupName]"
fi

awscli logs describe-log-groups --query "$QUERY" --output text