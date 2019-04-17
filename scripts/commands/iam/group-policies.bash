IAM_GROUPS=$(awscli iam list-groups --output text --query "Groups[$(auto_filter GroupName GroupId Path -- $@)].[GroupName]")

select_one Group "$IAM_GROUPS"

awscli iam list-group-policies --group-name $SELECTED --output table --query "PolicyNames[].{\"1.PolicyName\":@}"