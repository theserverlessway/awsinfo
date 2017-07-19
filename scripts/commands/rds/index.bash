FILTER_QUERY=""

if [[ $# -gt 0 ]]; then
    FILTER_ID+=$(filter_query "DBInstanceIdentifier" $@)
    FILTER_CLASS+=$(filter_query "DBInstanceClass" $@)
    FILTER_ENGINE+=$(filter_query "Engine" $@)
    FILTER_ENGINE_VERSION+=$(filter_query "EngineVersion" $@)
    FILTER_STATUS+=$(filter_query "DBInstanceStatus" $@)
    FILTER_ENDPOINT+=$(filter_query "Endpoint.Address" $@)
    FILTER_AZ+=$(filter_query "AvailabilityZone" $@)
    FILTER_DBCLUSTERIDENTIFIER+=$(filter_query "DBClusterIdentifier" $@)



    FILTER_QUERY="?$(join "||" $FILTER_ID $FILTER_CLASS $FILTER_ENGINE $FILTER_ENGINE_VERSION $FILTER_STATUS $FILTER_ENDPOINT $FILTER_AZ $FILTER_DBCLUSTERIDENTIFIER)"
fi

awscli rds describe-db-instances --output table --query "DBInstances[$FILTER_QUERY].{\"1.Id\":DBInstanceIdentifier,\"2.Class\":DBInstanceClass,\"3.Engine\":join(':',[Engine, EngineVersion]),\"4.Status\":DBInstanceStatus,\"5.AZ\":AvailabilityZone,\"6.Public\":PubliclyAccessible,\"7.Endpoint\":join(':',[Endpoint.Address, to_string(Endpoint.Port)])}"