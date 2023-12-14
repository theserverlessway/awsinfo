split_args "$@"

PROJECTS=$(awscli codebuild list-projects --output text --query "projects[$(auto_filter_joined @ -- "$FIRST_RESOURCE")].[@]")

select_one Project "$PROJECTS"

BUILD_IDS=$(awscli codebuild list-builds-for-project --project-name "$SELECTED" --max-items 100 --output text --query "ids[$(auto_filter_joined @ -- "$SECOND_RESOURCE")].[@]")

select_one_unsorted Build "$BUILD_IDS"