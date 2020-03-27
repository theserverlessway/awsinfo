split_args "$@"

REPOSITORIES=$(awscli codecommit list-repositories --output text --query "repositories[$(auto_filter repositoryName repositoryId -- $FIRST_RESOURCE)].[repositoryName]")
select_one Repository "$REPOSITORIES"

awscli codecommit list-branches --repository-name "$SELECTED" --output table --query "branches[$(auto_filter @ -- $SECOND_RESOURCE)]"