awscli batch describe-compute-environments --output table --query "sort_by(computeEnvironments,&computeEnvironmentName)[$(auto_filter_joined status state computeEnvironmentName type computeResources.type -- "$@")].{
  \"1.Name\":computeEnvironmentName,
  \"2.Type\":type,
  \"3.Provisioning\":computeResources.type,
  \"4.Status\":status,
  \"5.State\": state,
  \"6.InstanceTypes\":join(', ', computeResources.instanceTypes),
  \"7.CPU Min/Des/Max\":join(' / ', [to_string(computeResources.minvCpus), to_string(computeResources.desiredvCpus), to_string(computeResources.maxvCpus)]),
  \"8.ImageId\":computeResources.imageId}"
