source $CURRENT_COMMAND_DIR/loadbalancer_filter.sh

awscli elbv2 describe-load-balancer-attributes --load-balancer-arn "$SELECTED" --output table
