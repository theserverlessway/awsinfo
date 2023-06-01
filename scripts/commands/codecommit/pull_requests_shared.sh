split_args "$@"

REPOSITORIES=$(awscli codecommit list-repositories --output text --query "repositories[$(auto_filter_joined repositoryName repositoryId -- "$FIRST_RESOURCE")].[repositoryName]")

select_one Repository "$REPOSITORIES"

PULL_REQUESTS=$(awscli codecommit list-pull-requests --pull-request-status OPEN --repository-name "$SELECTED" --output text --query "pullRequestIds[$(auto_filter_joined @ -- "$SECOND_RESOURCE")].[@]")
