#!/bin/bash

set -euo pipefail

FILTER_QUERY=""

if [[ $# -gt 0 ]]; then
    FILTER_NAME+=$(filter_query "$TAG_NAME" $@)
    FILTER_ID+=$(filter_query "InstanceId" $@)

    FILTER_QUERY="?$(join "||" $FILTER_NAME $FILTER_ID)"
fi

awscli ec2 describe-instances --output table --filters Name=instance-state-name,Values=pending,running,shutting-down,stopping,stopped --query "Reservations[].Instances[$FILTER_QUERY][].{\"1.Name\":$TAG_NAME,\"2.InstanceId\":InstanceId,\"3.Type\":InstanceType,\"4.State\":State.Name,\"5.LaunchTime\":LaunchTime,\"6.AZ\":Placement.AvailabilityZone,\"7.PublicDNS\":PublicDnsName}"