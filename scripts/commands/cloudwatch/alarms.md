# `awsinfo cloudwatch alarms [substrings]*`

List all CloudWatch Alarms with their most important data. 

If `substrings` is given it will only print `Alarms` where all `substrings` are part of the `AlarmName`, `StateValue`,
`Namespace` or `MetricName`