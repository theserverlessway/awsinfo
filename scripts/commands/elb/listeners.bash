split_args "$@"

source $CURRENT_COMMAND_DIR/loadbalancer_filter.sh
FILTER=$(create_filter $FIRST_RESOURCE)

LOAD_BALANCERS=$(awscli elbv2 describe-load-balancers --output text --query "LoadBalancers[$FILTER].[LoadBalancerArn]")
select_one LoadBalancer "$LOAD_BALANCERS"

awscli elbv2 describe-listeners --load-balancer-arn $SELECTED --output table \
  --query "Listeners[$(auto_filter_joined 'to_string(Port)' Protocol -- $SECOND_RESOURCE)].{ \
    \"1.Port\":Port, \
    \"2.Protocol\":Protocol}"
