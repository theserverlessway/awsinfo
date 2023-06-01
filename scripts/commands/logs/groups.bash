awscli logs describe-log-groups  --output table --query "logGroups[$(auto_filter_joined logGroupName -- $@)].{
  \"1.Name\":logGroupName,
  \"2.Retention\":retentionInDays,
  \"3.StoredBytes\": storedBytes,
  \"4.MetricFilters\": metricFilterCount,
  \"5.CreatedAt\": creationTime}"
