CLUSTERS=$(awscli rds describe-db-clusters --output text --query "DBClusters[$(auto_filter_joined DBClusterIdentifier Engine EngineVersion EngineMode Status Endpoint -- $@)].[DBClusterIdentifier]")
select_one Cluster "$CLUSTERS"

awscli rds describe-db-clusters --output table --db-cluster-identifier $SELECTED --query "DBClusters[0]"