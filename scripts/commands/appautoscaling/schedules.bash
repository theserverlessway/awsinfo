split_args "$@"

source $CURRENT_COMMAND_DIR/service_namespace.sh

awscli application-autoscaling describe-scheduled-actions --service-namespace $FIRST_RESOURCE --output table --query "ScheduledActions[$(auto_filter ScalableDimension ResourceId -- $SECOND_RESOURCE)].{
  \"1.Name\":ScheduledActionName,
  \"2.Schedule\":Schedule,
  \"3.Resource\":ResourceId,
  \"4.Dimension\":ScalableDimension,
  \"5.New Min/Max\":join('/', [to_string(ScalableTargetAction.MinCapacity), to_string(ScalableTargetAction.MaxCapacity)])
  }"