ENVIRONMENTS=$(awscli elasticbeanstalk describe-environments --output text --query "sort_by(Environments,&EnvironmentName)[$(filter EnvironmentName "$@")].[EnvironmentName]")
select_one Environment "$ENVIRONMENTS"

awscli elasticbeanstalk describe-environment-health --environment-name $SELECTED --attribute-names All --output table --query "{\"1.EnvironmentName\":EnvironmentName,\"2.HealthStatus\":HealthStatus,\"3.Status\":Status,\"4.Color\":Color, \"5.ApplicationMetrics\":ApplicationMetrics,\"6.InstancesHealth\":InstancesHealth}"
