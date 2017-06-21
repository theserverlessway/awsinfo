FILTER_QUERY=""

if [[ $# -gt 0 ]]; then
    FILTER_NAME+=$(filter_query "AlarmName" $@)
    FILTER_STATE+=$(filter_query "StateValue" $@)
    FILTER_NAMESPACE+=$(filter_query "Namespace" $@)
    FILTER_METRIC+=$(filter_query "MetricName" $@)

    FILTER_QUERY="?$(join "||" $FILTER_NAME $FILTER_STATE $FILTER_NAMESPACE $FILTER_METRIC)"
fi

awscli cloudwatch describe-alarms --output table --query "MetricAlarms[$FILTER_QUERY].{\"1.Name\":AlarmName,\"2.Status\":StateValue,\"3.Metric\":join('/',[Namespace,MetricName]),\"4.Dimension\":Dimensions[].join('/',[Name,Value])|join(',',@),\"5.Comparison\":join('/',[ComparisonOperator,to_string(Threshold)])}"
