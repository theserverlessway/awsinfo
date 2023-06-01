COMPUTE_ENVIRONMENTS=$(awscli batch describe-compute-environments --output text --query "sort_by(computeEnvironments,&computeEnvironmentName)[$(auto_filter_joined status state computeEnvironmentName type computeResources.type -- "$@")].[computeEnvironmentName]")
select_one ComputeEnvironment "$COMPUTE_ENVIRONMENTS"

awscli batch describe-compute-environments --compute-environments $SELECTED --output table --query "computeEnvironments[0].{
  \"1.Name\":computeEnvironmentName,
  \"2.Type\":type
  \"3.Provisioning\":computeResources.type,
  \"4.Status\":status,
  \"5.State\": state,
  \"6.ComputeResources\":computeResources}"
