split_args "$@"

source $CURRENT_COMMAND_DIR/service_namespace.sh

awscli application-autoscaling describe-scaling-activities --service-namespace $FIRST_RESOURCE --max-items 200 --output table --query "ScalingActivities[$(auto_filter ResourceId ScalableDimension Cause StatusCode StatusMessage -- $SECOND_RESOURCE)].{
  \"1.Resource\":ResourceId,
  \"2.Dimension\":ScalableDimension,
  \"3.Cause\":Cause,
  \"4.StatusCode\":StatusCode,
  \"5.StatusMessage\":StatusMessage}"