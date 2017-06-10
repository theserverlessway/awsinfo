#!/bin/bash

set -euo pipefail

FILTER_QUERY=""

if [[ $# -gt 0 ]]; then
    FILTER_NAME+=$(filter_query "KeyName" $@)
    FILTER_ID+=$(filter_query "KeyFingerprint" $@)

    FILTER_QUERY="?$FILTER_NAME||$FILTER_ID"
fi

awscli ec2 describe-key-pairs --output table --query "KeyPairs[$FILTER_QUERY].{\"1.Name\":KeyName,\"2.Fingerprint\":KeyFingerprint}"