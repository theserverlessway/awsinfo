FILTER=$(auto_filter ID DomainName Status "(Aliases.Items||[''])|join(',',@)" -- $@)

DISTRIBUTIONS=$(awscli cloudfront list-distributions --output text --query "DistributionList.Items[$FILTER].[Id]")
select_one Distribution "$DISTRIBUTIONS"

awscli cloudfront get-distribution-config --id $SELECTED --output table --query "DistributionConfig.Origins.Items[].{\"1.Id\": Id, \"2.DomainName\": DomainName, \"3.OriginPath\": OriginPath, \"4.Config\": (S3OriginConfig||CustomOriginConfig)}"