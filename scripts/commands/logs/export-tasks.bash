awscli logs describe-export-tasks --output table --query "exportTasks[$(auto_filter_joined taskId taskName logGroupName destination status.code -- $@)].{
  \"1.Id\": taskId,
  \"2.Name\": taskName,
  \"3.LogGroup\": logGroupName,
  \"4.Destination\": join('',[destination,destinationPrefix]),
  \"5.From\": from,
  \"6.To\": to,
  \"7.Status\": join(' - ',[status.code,status.message])}"