RESOURCE=""
DIMENSION=""

while getopts "r:d:" opt; do
  case "$opt" in
  r) RESOURCE="--resource-id $OPTARG" ;;
  d) DIMENSION="--scalable-dimension $OPTARG" ;;
  esac
done
shift $(($OPTIND - 1))

split_args "$@"

source $CURRENT_COMMAND_DIR/service_namespace.sh

awscli application-autoscaling describe-scaling-activities --service-namespace $FIRST_RESOURCE --max-items 200 $RESOURCE $DIMENSION --output table --query "ScalingActivities[$(auto_filter_joined ResourceId ScalableDimension Cause StatusCode StatusMessage -- "$SECOND_RESOURCE")].{
  \"1.StartTime\":StartTime,
  \"2.Resource\":ResourceId,
  \"3.Dimension\":ScalableDimension,
  \"4.Cause\":Cause,
  \"5.StatusCode\":StatusCode}"