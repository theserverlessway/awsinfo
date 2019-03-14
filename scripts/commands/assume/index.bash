MFA=""

while getopts "md:" opt; do
    case "$opt" in
        d) MAX_DURATION="--duration-seconds $(expr $OPTARG \* 3600)" ;;
        m) MFA="TRUE" ;;
    esac
done
shift $(($OPTIND-1))

split_args "$@"

ACCOUNTS=$(awscli organizations list-accounts --output text --query "Accounts[$(auto_filter Name Id Status Email -- $FIRST_RESOURCE)].[Id]")
select_one Account "$ACCOUNTS"

ACCOUNT_ID=$SELECTED

ROLE="$SECOND_RESOURCE"

if [[ ! $ROLE ]]
then
  ROLE="OrganizationAccountAccessRole"
fi

read -r ACCOUNT USERNAME <<<$(awscli sts get-caller-identity --query "[Account, Arn]" --output text | sed 's/arn.*\///g')

if [[ ! -z "$MFA" ]]
then
  MFA_DEVICE=arn:aws:iam::$ACCOUNT:mfa/$USERNAME
  SERIAL_NUMBER="--serial-number $MFA_DEVICE"
  read -p "MFA TOKEN: " TOKEN
  TOKEN_CODE="--token-code $TOKEN"
fi

awscli sts assume-role --role-arn arn:aws:iam::$SELECTED:role/$ROLE ${SERIAL_NUMBER:-} ${TOKEN_CODE:-} ${MAX_DURATION:-} --role-session-name $ACCOUNT_ID-$ROLE-$USERNAME-$RANDOM --output json | jq -r '.Credentials | "export AWS_ACCESS_KEY_ID=" + .AccessKeyId + " AWS_SECRET_ACCESS_KEY=" + .SecretAccessKey + " AWS_SESSION_TOKEN=\"" + .SessionToken + "\" AWS_TOKEN_EXPIRATION=" + .Expiration'
