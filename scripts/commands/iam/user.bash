USERS=$(awscli iam list-users --output text --query "Users[$(auto_filter_joined UserName UserId Path -- $@)].[UserName]")
select_one User "$USERS"

awscli iam get-user --user-name $SELECTED --output table --query "User"