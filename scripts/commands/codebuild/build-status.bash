source $CURRENT_COMMAND_DIR/build_selection.sh

awscli codebuild batch-get-builds --output table --ids $SELECTED --query "builds[].{
  \"1.Id\":id,
  \"2.Number\":buildNumber,
  \"3.Phase\":currentPhase,
  \"4.Status\":buildStatus,
  \"5.StartedAt\":startTime,
  \"6.FinishedAt\":endTime,
  \"7.Environment\":environment}"