split_args "$@"

source $CURRENT_COMMAND_DIR/service_namespace.sh

POLICY_LIST=$(awscli application-autoscaling describe-scaling-policies --service-namespace $FIRST_RESOURCE --output text --query "ScalingPolicies[$(auto_filter_joined ScalableDimension ResourceId PolicyName -- "$SECOND_RESOURCE")].[PolicyName]")

select_one Policy "$POLICY_LIST"

awscli application-autoscaling describe-scaling-policies --policy-names $SELECTED --service-namespace $FIRST_RESOURCE --output table --query "ScalingPolicies[0]"

