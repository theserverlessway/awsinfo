split_args "$@"

DOMAIN_NAMES=$(awscli es list-domain-names --output text --query "sort_by(DomainNames,&DomainName)[$(auto_filter DomainName -- $FIRST_RESOURCE)].[DomainName]")
select_one DomainName "$DOMAIN_NAMES"

awscli es describe-elasticsearch-domain --domain-name $SELECTED --output table \
  --query "DomainStatus.{ \
    \"1.Name\":DomainName, \
    \"2.Endpoint\":Endpoint, \
    \"3.Version\":ElasticsearchVersion, \
    \"4.Cluster\":ElasticsearchClusterConfig, \
    \"5.VPCOptions\":VPCOptions||{VPCId: 'None'}, \
    \"6.EBSOptions\":EBSOptions}"
