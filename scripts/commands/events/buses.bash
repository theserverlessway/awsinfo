# Example of a Simple Command

awscli events list-event-buses --output table --query "sort_by(EventBuses,&Name)[$(auto_filter_joined Name Arn -- "$@")].{
  \"1.Name\":Name,
  \"2.Arn\":Arn}"
