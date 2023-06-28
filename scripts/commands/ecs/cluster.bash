CLUSTERS=$(awscli ecs list-clusters --output text --query "clusterArns[$(auto_filter_joined @ -- "$@")].[@]")
select_one Cluster "$CLUSTERS"

awscli ecs describe-clusters --output table --clusters "$SELECTED"