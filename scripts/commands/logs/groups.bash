#!/bin/bash

set -euo pipefail

QUERY="logGroups[$(filter logGroupName $@)].[logGroupName]"

awscli logs describe-log-groups --query "$QUERY" --output text