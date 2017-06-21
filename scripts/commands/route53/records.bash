FILTER_QUERY=""

if [[ $# -gt 0 ]]; then
    FILTER_NAME+=$(filter_query "Name" $@)
    FILTER_ID+=$(filter_query "Id" $@)

    FILTER_QUERY="?$(join "||" $FILTER_NAME $FILTER_ID)"
fi

HOSTED_ZONES=$(awscli route53 list-hosted-zones --output text --query "HostedZones[$FILTER_QUERY].[Id]")
select_one HostedZone "$HOSTED_ZONES"

awscli route53 list-resource-record-sets --hosted-zone-id $SELECTED --output table --query "ResourceRecordSets[].{\"1.Name\":Name,\"2.Type\":Type,\"3.TTL\":TTL||'',\"4.Records\":(ResourceRecords[].Value||(['Alias',join('/',[AliasTarget.HostedZoneId,AliasTarget.DNSName])]|[join(':',@)]))|join(' | ',@)}"