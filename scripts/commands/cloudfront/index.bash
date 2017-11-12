FILTER_QUERY=""

if [[ $# -gt 0 ]]; then
    FILTER_ID+=$(filter_query "Id" $@)
    FILTER_DOMAIN+=$(filter_query "DomainName" $@)
    FILTER_STATUS+=$(filter_query "Status" $@)
    FILTER_ALIAS+=$(filter_query "(Aliases.Items||[''])|join(',',@)" $@)

    FILTER_QUERY="?$(join "||" $FILTER_ID $FILTER_DOMAIN $FILTER_STATUS $FILTER_ALIAS)"
fi

FILTER=$(auto_filter Id DomainName Status "join(',',Aliases.Items||[''])" -- $@)

awscli cloudfront list-distributions --output table --query "DistributionList.Items[$FILTER].{ \
  \"1.Id\": Id, \
  \"2.DomainName\": DomainName, \
  \"3.Status\": Status, \
  \"4.Enabled\":Enabled, \
  \"5.PriceClass\": PriceClass, \
  \"6.Aliases\": (Aliases.Items||[''])|join(',',@), \
  \"7.Origins\": Origins.Quantity, \
  \"8.CacheBehaviors\": CacheBehaviors.Quantity}"