awscli apigateway get-domain-names --output table --query "sort_by(items,&domainName)[$(auto_filter_joined domainName -- $@)].{
  \"1.Name\":domainName,
  \"2.RegionalDomainName\":regionalDomainName,
  \"3.Endpoint\": join(',', endpointConfiguration.types||[]),
  \"4.Status\":domainNameStatus,
  \"5.SecurityPolicy\":securityPolicy}"