FILTER=$(auto_filter_joined DBInstanceIdentifier DBInstanceClass Engine EngineVersion DBInstanceStatus Endpoint.Address AvailabilityZone "DBClusterIdentifier||''" -- $@)

RDS_INSTANCES=$(awscli rds describe-db-instances --output text --query "DBInstances[$FILTER].[DBInstanceIdentifier]")
select_one Instance "$RDS_INSTANCES"

awscli rds describe-db-instances --db-instance-identifier $SELECTED --output table --query "DBInstances[0]"