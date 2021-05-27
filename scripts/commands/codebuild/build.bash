split_args "$@"

PROJECTS=$(awscli codebuild list-projects --output text --query "projects[$(auto_filter @ -- $FIRST_RESOURCE)].[@]")

select_one Project "$PROJECTS"

BUILD_IDS=$(awscli codebuild list-builds-for-project --project-name $SELECTED --output text --query "ids[$(auto_filter @ -- $SECOND_RESOURCE)].[@]")

select_one Build "$BUILD_IDS"

# Now we can call the `describe-change-set` command with the Stack and ChangeSet we selected above.
# The output is set to table and we're using the Query option to select the values we want to have.
awscli codebuild batch-get-builds --output table --query builds --ids $SELECTED