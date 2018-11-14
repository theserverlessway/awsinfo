awscli rds describe-db-instances --output table --query "DBInstances[$(auto_filter DBInstanceIdentifier DBInstanceClass Engine EngineVersion DBInstanceStatus Endpoint.Address AvailabilityZone DBClusterIdentifier -- $@)].{ \
    \"1.Id\":DBInstanceIdentifier, \
    \"2.Class\":DBInstanceClass, \
    \"3.Engine\":join(':',[Engine, EngineVersion]), \
    \"4.Status\":DBInstanceStatus, \
    \"5.AZ\":AvailabilityZone, \
    \"6.Public\":PubliclyAccessible, \
    \"7.Cluster\": DBClusterIdentifier, \
    \"8.Endpoint\":join(':',[Endpoint.Address||'', to_string(Endpoint.Port||'')])}"
