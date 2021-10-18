REPOSITORIES=$(awscli codecommit list-repositories --output text --query "repositories[$(auto_filter repositoryName repositoryId -- $@)].[repositoryName]")

select_one Repository "$REPOSITORIES"

awscli codecommit get-repository --repository-name $SELECTED --output table --query "repositoryMetadata"