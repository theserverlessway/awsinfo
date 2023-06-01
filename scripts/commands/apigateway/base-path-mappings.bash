split_args "$@"

DOMAIN_NAMES=$(awscli apigateway get-domain-names --output text --query "items[$(auto_filter_joined domainName -- "$FIRST_RESOURCE")].[domainName]")
select_one DomainName "$DOMAIN_NAMES"

awscli apigateway get-base-path-mappings --domain-name $SELECTED --output table --query "items[$(auto_filter_joined basePath restApiId stage -- "$SECOND_RESOURCE")]"