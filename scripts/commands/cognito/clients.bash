USER_POOLS=$(awscli cognito-idp list-user-pools --max-results 60 --output text --query "sort_by(UserPools,&Name)[$(auto_filter_joined Id Name -- "$@")].[Id]")
select_one UserPool "$USER_POOLS"

awscli cognito-idp list-user-pool-clients --max-results 60 --user-pool-id $SELECTED --output table --query "UserPoolClients[].{
  \"1.ClientId\": ClientId,
  \"2.ClientName\": ClientName}"