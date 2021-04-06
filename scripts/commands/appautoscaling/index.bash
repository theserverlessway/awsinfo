split_args "$@"

source $CURRENT_COMMAND_DIR/service_namespace.sh

awscli application-autoscaling describe-scaling-activities --service-namespace $FIRST_RESOURCE --max-items 200 --output table --query "ScalingActivities[$(auto_filter ResourceId ScalableDimension Cause StatusCode StatusMessage -- $SECOND_RESOURCE)].{
  \"1.StartTime\":StartTime,
  \"2.Resource\":ResourceId,
  \"3.Dimension\":ScalableDimension,
  \"4.Cause\":Cause,
  \"5.StatusCode\":StatusCode}"