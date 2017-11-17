split_args "$@"

ORGANIZATIONS=$(awscli organizations list-accounts --output text --query "Accounts[$(auto_filter Name Id Status Email -- $FIRST_RESOURCE)].[Id]")
select_one Organization "$ORGANIZATIONS"

ROLE="$SECOND_RESOURCE"

if [[ ! $ROLE ]]
then
  ROLE="OrganizationAccountAccessRole"
fi

awscli sts assume-role --role-arn arn:aws:iam::$SELECTED:role/$ROLE --role-session-name $SELECTED-$ROLE-$RANDOM --output json | jq -r '.Credentials | "export AWS_ACCESS_KEY_ID=" + .AccessKeyId + " AWS_SECRET_ACCESS_KEY=" + .SecretAccessKey + " AWS_SESSION_TOKEN=\"" + .SessionToken + "\""'
