FILTER=$(auto_filter_joined jobQueueName status "join('',computeEnvironmentOrder[].computeEnvironment)" -- $@)

awscli batch describe-job-queues --output json --query "sort_by(jobQueues,&jobQueueName)[$FILTER].{
  \"1.Name\":jobQueueName,
  \"2.State\":state,
  \"3.Status\":status,
  \"4.ComputeEnvironmentsOrder\":join(', ', map(&join(':', [to_string(@.order), @.computeEnvironment]), sort_by(computeEnvironmentOrder, &order)))}" | sed "s/arn:aws:batch:[a-z1-9-]*:[0-9]*:compute-environment\///g" | print_table ListStackInstances
