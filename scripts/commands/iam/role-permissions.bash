ROLES=$(awscli iam list-roles --output text --query "Roles[$(auto_filter_joined RoleName RoleId -- "$@")].[RoleName]")
select_one Role "$ROLES"

ROLE_POLICIES=$(awscli iam list-role-policies --role-name $SELECTED --query PolicyNames --output text)

for policy in $ROLE_POLICIES
do
  awscli iam get-role-policy --role-name $SELECTED --policy-name "$policy"  --output json
done


ATTACHED_ROLE_POLICIES=$(awscli iam list-attached-role-policies --role-name "$SELECTED" --output text --query "AttachedPolicies[].PolicyArn")

for policy in $ATTACHED_ROLE_POLICIES
do
  VERSION=$(awscli iam list-policy-versions --policy-arn "$policy" --output text --query "Versions[?IsDefaultVersion].VersionId")
  awscli iam get-policy-version --policy-arn "$policy" --version-id "$VERSION" --output json --query "PolicyVersion"
done
