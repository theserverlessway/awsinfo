FILTER=$(auto_filter_joined name version -- "$@")

awscli codepipeline list-pipelines --output table --query "pipelines[$FILTER].{
  \"1.Name\":name,
  \"2.Version\":version,
  \"3.Created\":created,
  \"4.Updated\":updated}"