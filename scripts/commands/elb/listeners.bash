source $CURRENT_COMMAND_DIR/loadbalancer_filter.sh

awscli elbv2 describe-listeners --load-balancer-arn "$SELECTED" --output table \
  --query "Listeners[$(auto_filter_joined 'to_string(Port)' Protocol -- "$SECOND_RESOURCE")].{ \
    \"1.Port\":Port, \
    \"2.Protocol\":Protocol}"
