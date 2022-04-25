NAMESPACE=""

while getopts "n:c:" opt; do
  case "$opt" in
  c) NAMESPACE="--namespace $OPTARG" ;;
  n) NAMESPACE="--namespace AWS/$OPTARG" ;;
  esac
done
shift $(($OPTIND - 1))

FILTER=$(auto_filter_joined Namespace MetricName "join('',Dimensions[].Name)" "join('',Dimensions[].Value)" -- $@)

awscli cloudwatch list-metrics $NAMESPACE --recently-active PT3H --output table --query "Metrics[$FILTER]"
