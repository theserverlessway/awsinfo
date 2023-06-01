awscli rds describe-db-engine-versions --output table \
  --query "DBEngineVersions[$(auto_filter_joined Engine EngineVersion DBParameterGroupFamily -- "$@")].{ \
    \"1.Engine\":Engine, \
    \"2.EngineVersion\":EngineVersion, \
    \"3.Family\":DBParameterGroupFamily, \
    \"4.SupportsReadReplica\":SupportsReadReplica}"
