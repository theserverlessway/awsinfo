split_args "$@"

HOSTED_ZONES=$(awscli route53 list-hosted-zones --output text --query "HostedZones[$(auto_filter Name Id -- $FIRST_RESOURCE)].[Id]")
select_one HostedZone "$HOSTED_ZONES"

awscli route53 list-resource-record-sets --hosted-zone-id $SELECTED --output table --query "ResourceRecordSets[$(auto_filter Name Type 'to_string(TTL)' -- $SECOND_RESOURCE)].{\"1.Name\":Name,\"2.Type\":Type,\"3.TTL\":TTL||'',\"4.Records\":(ResourceRecords[].Value||(['Alias',join('/',[AliasTarget.HostedZoneId,AliasTarget.DNSName])]|[join(':',@)]))|join(' | ',@)}"