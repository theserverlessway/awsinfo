split_args "$@"

ENVIRONMENTS=$(awscli elasticbeanstalk describe-environments --output text --query "sort_by(Environments,&EnvironmentName)[$(auto_filter_joined EnvironmentName -- "$FIRST_RESOURCE")].[EnvironmentName]")
select_one Environment "$ENVIRONMENTS"

awscli elasticbeanstalk describe-instances-health --environment-name "$SELECTED" --attribute-names All --output table --query  \
  "InstanceHealthList[$(auto_filter_joined InstanceId AvailabilityZone Deployment.VersionLabel HealthStatus Color -- "$SECOND_RESOURCE")]. \
  {\"1.InstanceId\":InstanceId, \
   \"2.Health\":HealthStatus, \
   \"3.Color\":Color, \
   \"4.Load\":join(' | ',System.LoadAverage[].to_string(@)), \
   \"5.Latency p999|p99|p95\": join(' | ', ApplicationMetrics.Latency.[to_string(P999), to_string(P99), to_string(P95)] || ['0','0','0']), \
   \"6.Requests 2xx|3xx|4xx|5xx\":join(': ', [to_string(ApplicationMetrics.RequestCount), join(' | ',ApplicationMetrics.StatusCodes.[to_string(Status2xx),to_string(Status3xx),to_string(Status4xx),to_string(Status5xx)] || ['0','0','0', '0'])]), \
   \"7.Version\":join(': ', [Deployment.VersionLabel, Deployment.Status]), \
   \"8.AZ\":AvailabilityZone, \
   \"9.Type\":InstanceType }"
