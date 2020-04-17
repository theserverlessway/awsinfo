split_args "$@"

source $CURRENT_COMMAND_DIR/service_namespace.sh

awscli application-autoscaling describe-scaling-policies --service-namespace $FIRST_RESOURCE --output table --query "ScalingPolicies[$(auto_filter ScalableDimension ResourceId -- $SECOND_RESOURCE)].{
  \"1.PolicyName\":PolicyName,
  \"2.Dimension\":ScalableDimension,
  \"3.ResourceId\":ResourceId}"