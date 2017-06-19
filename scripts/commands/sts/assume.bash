if [[ ! "$#" -eq 2 ]]
then
    echo "Usage: assume-role ACCOUNTID ROLENAME"
fi

ACCOUNT_ID=$1
ROLE=$2

awscli sts assume-role --role-arn arn:aws:iam::$ACCOUNT_ID:role/$ROLE --role-session-name $ACCOUNT_ID-$ROLE-$RANDOM | jq -r '.Credentials | "export AWS_ACCESS_KEY_ID=" + .AccessKeyId + " AWS_SECRET_ACCESS_KEY=" + .SecretAccessKey + " AWS_SESSION_TOKEN=\"" + .SessionToken + "\""'