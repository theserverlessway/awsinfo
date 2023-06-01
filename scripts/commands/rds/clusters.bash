awscli rds describe-db-clusters --output table --query "DBClusters[$(auto_filter_joined DBClusterIdentifier Engine EngineVersion EngineMode Status Endpoint -- "$@")].{ \
    \"1.Id\":DBClusterIdentifier, \
    \"2.Engine\":join(':',[Engine, EngineVersion, EngineMode]), \
    \"3.Status\":Status, \
    \"4.AZs\":join(', ', AvailabilityZones),
    \"5.MultiAZ\":MultiAZ,
    \"6.ClusterMembers\":length(DBClusterMembers),
    \"7.ReadReplicas\":length(ReadReplicaIdentifiers),
    \"8.Encrypted\":StorageEncrypted,
    \"9.DeletionProtection\":DeletionProtection}"
