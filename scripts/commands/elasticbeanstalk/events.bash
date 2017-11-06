ENVIRONMENTS=$(awscli elasticbeanstalk describe-environments --output text --query "sort_by(Environments,&EnvironmentName)[$(filter EnvironmentName $@)].[EnvironmentName]")
select_one Environment "$ENVIRONMENTS"

awscli elasticbeanstalk describe-events --environment-name $SELECTED --output table --query "Events[0:50]|reverse(@)[].{\"1.EventDate\":EventDate,\"2.Severity\":Severity,\"3.Message\":Message}"
