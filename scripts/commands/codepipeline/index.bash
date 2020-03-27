awscli codepipeline list-pipelines --output table --query "pipelines[$(auto_filter name version -- $@)].{
  \"1.Name\":name,
  \"2.Version\":version,
  \"3.Created\":created,
  \"4.Updated\":updated}"