FILTER_QUERY=""

if [[ $# -gt 0 ]]; then
    FILTER_NAME+=$(filter_query "ApplicationName" $@)
    FILTER_ENV_NAME+=$(filter_query "EnvironmentName" $@)
    FILTER_STATUS+=$(filter_query "Status" $@)
    FILTER_HEALTH+=$(filter_query "Health" $@)
    FILTER_ID+=$(filter_query "EnvironmentId" $@)
    FILTER_CNAME+=$(filter_query "CNAME" $@)


    FILTER_QUERY="?$(join "||" $FILTER_NAME $FILTER_ENV_NAME $FILTER_STATUS $FILTER_HEALTH $FILTER_ID $FILTER_CNAME)"
fi

awscli elasticbeanstalk describe-environments --output table --query "sort_by(Environments,&join('-',[ApplicationName, EnvironmentName]))[$FILTER_QUERY].{\"1.ApplicationName\":ApplicationName,\"2.EnvironmentName\":EnvironmentName,\"3.Status\":Status, \"4.Health\":Health, \"5.EnvironmentId\":EnvironmentId, \"6.CNAME\":CNAME}"