source $CURRENT_COMMAND_DIR/loadbalancer_filter.sh

LISTENER_FILTER=$(auto_filter_joined "to_string(Port)" Protocol -- "$SECOND_RESOURCE")

LISTENERS=$(awscli elbv2 describe-listeners --load-balancer-arn "$SELECTED" --output text --query "Listeners[$LISTENER_FILTER].[ListenerArn]")
select_one Listener "$LISTENERS"

awscli elbv2 describe-rules --listener-arn "$SELECTED" --output table
