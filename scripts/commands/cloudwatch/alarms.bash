FILTER=$(auto_filter AlarmName StateValue "Namespace||['']" "MetricName||['']" -- $@)

awscli cloudwatch describe-alarms --output table --query "MetricAlarms[$FILTER].{
  \"1.Name\":AlarmName,
  \"2.Status\":StateValue,
  \"3.Metric\":join('/',[Namespace||'',MetricName||'']),
  \"4.Dimension\":Dimensions[].join('/',[Name,Value])|join(',',@),
  \"5.Comparison/Threshold\":join('/',[ComparisonOperator,to_string(Threshold)]),
  \"6.Periods/Length\":join('/',[to_string(Period),to_string(EvaluationPeriods)])}"
