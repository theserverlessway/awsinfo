split_args "$@"

source $CURRENT_COMMAND_DIR/loadbalancer_filter.sh
FILTER=$(create_filter $FIRST_RESOURCE)

LOAD_BALANCERS=$(awscli elbv2 describe-load-balancers --output text --query "LoadBalancers[$FILTER].[LoadBalancerArn]")
select_one LoadBalancer "$LOAD_BALANCERS"

LISTENER_FILTER=$(auto_filter_joined "to_string(Port)" Protocol -- "$SECOND_RESOURCE")

LISTENERS=$(awscli elbv2 describe-listeners --load-balancer-arn $SELECTED --output text --query "Listeners[$LISTENER_FILTER].[ListenerArn]")
select_one Listener "$LISTENERS"

awscli elbv2 describe-listener-certificates --listener-arn $SELECTED --output table --query "Certificates"
