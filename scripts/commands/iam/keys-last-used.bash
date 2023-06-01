USERS=$(awscli iam list-users --output text --query "Users[$(auto_filter_joined UserName UserId Path -- $@)].[UserName]")
select_one User "$USERS"

awscli iam list-access-keys --user-name $SELECTED --output text --query AccessKeyMetadata[].AccessKeyId | xargs -n 1 -I {} bash -c "echoinfomsg AccessKeyId: {} && awscli iam get-access-key-last-used --output table --access-key-id {}"