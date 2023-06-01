split_args "$@"

IAM_GROUPS=$(awscli iam list-groups --output text --query "Groups[$(auto_filter_joined GroupName GroupId -- $FIRST_RESOURCE )].[GroupName]")
select_one Group "$IAM_GROUPS"

GROUP=$SELECTED

IAM_GROUPS=$(awscli iam list-group-policies --group-name $GROUP --output text --query "PolicyNames[$(filter @ $SECOND_RESOURCE)].[@]")
select_one Policy "$IAM_GROUPS"

awscli iam get-group-policy --group-name $GROUP --policy-name $SELECTED --output table --query "@.{
  \"PolicyStatement\":PolicyDocument.Statement[].{
    \"1.Effect\": Effect,
    \"2.Action\": [Action][],
    \"3.Resource\": [Resource][]}}"
