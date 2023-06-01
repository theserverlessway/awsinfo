awscli apigatewayv2 get-domain-names --output table --query "sort_by(Items,&DomainName)[$(auto_filter_joined DomainName -- $@)].{
  \"1.DomainName\":DomainName}"