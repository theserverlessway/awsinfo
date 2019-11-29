split_args "$@"

SSM_INSTANCES=$(awscli ssm describe-instance-information --query "InstanceInformationList[$(auto_filter InstanceId PlatformType PlatformName PlatformVersion AgentVersion PingStatus -- $FIRST_RESOURCE)].[InstanceId]" --output text)

# And again Select a ChangeSet as before and set the SELECTED variable to that Change Set
select_one Instance "$SSM_INSTANCES"

awscli  ssm describe-instance-associations-status --instance-id "$SELECTED" --output table --query "InstanceAssociationStatusInfos[$(auto_filter AssociationId Name AssociationName ExecutionDate Status -- $SECOND_RESOURCE)].{
  \"1.Id\":AssociationId,
  \"2.Name\":Name,
  \"3.AssociationName\":AssociationName,
  \"4.DocumentVersion\":DocumentVersion,
  \"5.AssociationVersion\":AssociationVersion,
  \"6.ExecutionDate\":ExecutionDate,
  \"7.Status\":Status,
  \"8.DetailedStatus\":DetailedStatus}"