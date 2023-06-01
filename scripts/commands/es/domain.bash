split_args "$@"

DOMAIN_NAMES=$(awscli es list-domain-names --output text --query "sort_by(DomainNames,&DomainName)[$(auto_filter_joined DomainName -- "$FIRST_RESOURCE")].[DomainName]")
select_one DomainName "$DOMAIN_NAMES"

awscli es describe-elasticsearch-domain --domain-name "$SELECTED" --output table \
  --query "DomainStatus"
