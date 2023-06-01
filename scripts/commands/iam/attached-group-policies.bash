GROUPS_LIST=$(awscli iam list-groups --output text --query "Groups[$(auto_filter_joined GroupName GroupId -- "$@")].[GroupName]")
select_one Group "$GROUPS_LIST"
awscli iam list-attached-group-policies --group-name "$SELECTED" --output table --query "AttachedPolicies[]"