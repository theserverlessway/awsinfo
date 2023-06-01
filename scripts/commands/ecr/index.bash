awscli ecr describe-repositories --output table --query "repositories[$(auto_filter_joined repositoryName repositoryUri -- "$@")].{\"1.Name\":repositoryName,\"2.Uri\":repositoryUri}"
