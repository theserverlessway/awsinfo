awscli codecommit list-repositories --output table --query "repositories[$(auto_filter_joined repositoryName repositoryId -- "$@")].{
  \"1.Name\":repositoryName,
  \"2.Id\":repositoryId}"