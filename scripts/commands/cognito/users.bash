split_args "$@"

USER_POOLS=$(awscli cognito-idp list-user-pools --max-results 60 --output text --query "sort_by(UserPools,&Name)[$(auto_filter Id Name -- $FIRST_RESOURCE)].[Id]")
select_one UserPool "$USER_POOLS"

function attribute(){
  echo "Attributes[?Name=='$1'].Value|[0]"
}

LAST_NAME=$(attribute name)
FIRST_NAME=$(attribute given_name)
EMAIL=$(attribute email)

awscli cognito-idp list-users --user-pool-id $SELECTED --output table --query "Users[$(auto_filter Username $LAST_NAME $FIRST_NAME $EMAIL -- $SECOND_RESOURCE)].{\"1.Username\": Username,\"2.Status\": UserStatus, \"3.Email\": $EMAIL, \"3.FirstName\": $FIRST_NAME, \"4.LastName\": $LAST_NAME}"