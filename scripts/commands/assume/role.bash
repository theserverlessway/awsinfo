SERIAL_OPTIONS=""

if [[ $# -eq 4 ]]
then
  SERIAL_OPTIONS="--serial-number $3 --token-code $4"
fi

awscli sts assume-role --role-arn arn:aws:iam::$1:role/$2 $SERIAL_OPTIONS --role-session-name $1-$2-$RANDOM --output json | jq -r '.Credentials | "export AWS_ACCESS_KEY_ID=" + .AccessKeyId + " AWS_SECRET_ACCESS_KEY=" + .SecretAccessKey + " AWS_SESSION_TOKEN=\"" + .SessionToken + "\""'