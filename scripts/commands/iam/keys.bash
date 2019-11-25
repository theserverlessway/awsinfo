USERS=$(awscli iam list-users --output text --query "Users[$(auto_filter UserName UserId Path -- $@)].[UserName]")
select_one User "$USERS"

awscli iam list-access-keys --user-name $SELECTED --output table --query AccessKeyMetadata