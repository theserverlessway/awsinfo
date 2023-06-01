split_args "$@"

RULES=$(awscli events list-rules --output text --query "sort_by(Rules,&Name)[$(auto_filter_joined Name -- "$FIRST_RESOURCE")].[Name]")
select_one Rule "$RULES"

awscli events list-targets-by-rule --rule $SELECTED --output table \
   --query "Targets[$(auto_filter_joined Id Arn RoleArn -- "$SECOND_RESOURCE")]"
