FILTER=$(auto_filter Id DomainName Status "(Aliases.Items||[''])|join(',',@)" -- $@)

DISTRIBUTIONS=$(awscli cloudfront list-distributions --output text --query "DistributionList.Items[$FILTER].[Id]")
select_one Distribution "$DISTRIBUTIONS"

awscli cloudfront get-distribution-config --id $SELECTED --output table --query "DistributionConfig.Origins.Items[]"