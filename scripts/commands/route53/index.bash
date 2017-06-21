FILTER_QUERY=""

if [[ $# -gt 0 ]]; then
    FILTER_NAME+=$(filter_query "Name" $@)
    FILTER_ID+=$(filter_query "Id" $@)

    FILTER_QUERY="?$(join "||" $FILTER_NAME $FILTER_ID)"
fi


awscli route53 list-hosted-zones --output table --query "HostedZones[$FILTER_QUERY].{\"1.Name\":Name,\"2.Id\":Id,\"3.Private\":Config.PrivateZone,\"4.RecordSets\":ResourceRecordSetCount}"