source $CURRENT_COMMAND_DIR/loadbalancer_filter.sh

awscli elbv2 describe-target-groups --load-balancer-arn "$SELECTED" --output table \
  --query "TargetGroups[$(auto_filter_joined TargetGroupName 'to_string(Port)' Protocol -- "$SECOND_RESOURCE")].{ \
    \"1.Name\":TargetGroupName, \
    \"2.Protocol\":Protocol, \
    \"3.Port\":Port, \
    \"4.HealthCheckPath\":HealthCheckPath, \
    \"5.HealthCheckProtocol\":HealthCheckProtocol}"
