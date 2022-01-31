EXPORT_LISTING=$(awscli cloudformation list-exports --output text --query "sort_by(Exports,&Name)[$(auto_filter Name -- $@)].[Name]")
select_one Stack "$EXPORT_LISTING"

awscli cloudformation list-imports --export-name $SELECTED --query "Imports" --output table