ROLES=$(awscli iam list-roles --output text --query "Roles[$(auto_filter RoleName RoleId -- $@)].[RoleName]")
select_one Role "$ROLES"

awscli iam get-role --role-name $SELECTED --output table --query "Role.{\"1.Name\": RoleName, \"2.Id\": RoleId, \"3.AssumeRolePolicyDocument\": AssumeRolePolicyDocument.Statement}"