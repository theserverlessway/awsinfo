#!/bin/bash

set -euo pipefail

FILTER_QUERY=""

if [[ $# -gt 1 ]]; then
    echo "Plase provide one argument to match your cloudformation stacks"
    exit 1
fi

if [[ $# == 1 ]]; then
  FILTER_QUERY="?contains(Tags[?Key=='Name'].Value|to_string([0]),'$1')||contains(InstanceId,'$1')"
fi

awscli ec2 describe-instances --output table --filters Name=instance-state-name,Values=pending,running,shutting-down,stopping,stopped --query "Reservations[].Instances[$FILTER_QUERY][].{\"1.Name\":Tags[?Key=='Name'].Value|[0],\"2.InstanceId\":InstanceId,\"3.Type\":InstanceType,\"4.State\":State.Name,\"5.LaunchTime\":LaunchTime,\"6.AZ\":Placement.AvailabilityZone,\"7.PublicDNS\":PublicDnsName,\"8.PrivateDNS\":PrivateDnsName}"