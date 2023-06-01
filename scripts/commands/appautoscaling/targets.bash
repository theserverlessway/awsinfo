split_args "$@"

source $CURRENT_COMMAND_DIR/service_namespace.sh

awscli application-autoscaling describe-scalable-targets --service-namespace $FIRST_RESOURCE --output table --query "ScalableTargets[$(auto_filter_joined ScalableDimension ResourceId -- $SECOND_RESOURCE)].{
  \"1.Resource\":ResourceId,
  \"2.Dimension\":ScalableDimension,
  \"3.MinCapacity\":MinCapacity,
  \"4.MaxCapacity\":MaxCapacity,
  \"5.CreatedAt\":CreationTime
  }"