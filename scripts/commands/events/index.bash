FILTER=$(auto_filter Name State "ScheduleExpression||''" "EventPattern||''" -- $@)

awscli events list-rules --output table \
  --query "Rules[$FILTER].{ \
    \"1.Name\":Name, \
    \"2.State\":State, \
    \"3.Schedule\":ScheduleExpression||'', \
    \"4.EventPattern\":EventPattern||''}"
