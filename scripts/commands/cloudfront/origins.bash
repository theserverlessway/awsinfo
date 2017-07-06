FILTER_QUERY=""

if [[ $# -gt 0 ]]; then
    FILTER_ID+=$(filter_query "Id" $@)
    FILTER_DOMAIN+=$(filter_query "DomainName" $@)
    FILTER_STATUS+=$(filter_query "Status" $@)
    FILTER_ALIAS+=$(filter_query "(Aliases.Items||[''])|join(',',@)" $@)

    FILTER_QUERY="?$(join "||" $FILTER_ID $FILTER_DOMAIN $FILTER_STATUS $FILTER_ALIAS)"
fi

DISTRIBUTIONS=$(awscli cloudfront list-distributions --output text --query "DistributionList.Items[$FILTER_QUERY].[Id]")
select_one Distribution "$DISTRIBUTIONS"

awscli cloudfront get-distribution-config --id $SELECTED --output table --query "DistributionConfig.Origins.Items[].{\"1.Id\": Id, \"2.DomainName\": DomainName, \"3.OriginPath\": OriginPath, \"4.Config\": (S3OriginConfig||CustomOriginConfig)}"