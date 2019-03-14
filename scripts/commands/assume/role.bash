ACCOUNT_ID=""
ROLE_NAME=""
SERIAL_NUMBER=""
TOKEN_CODE=""
MFA=""
while getopts "ms:t:d:a:r:" opt; do
    case "$opt" in
        t) TOKEN_CODE="--token-code $OPTARG" ;;
        s) SERIAL_NUMBER="--serial-number $OPTARG" ;;
        m) MFA="TRUE" ;;
        d) MAX_DURATION="--duration-seconds $(expr $OPTARG \* 3600)" ;;
        a) ACCOUNT_ID="$OPTARG" ;;
        r) ROLE_NAME="$OPTARG" ;;
    esac
done
shift $(($OPTIND-1))

if [[ -z "$ROLE_NAME" ]]
then
  echo "Please set the Role Name with -r"
  exit 1
fi

read -r ACCOUNT USERNAME <<<$(awscli sts get-caller-identity --query "[Account, Arn]" --output text | sed 's/arn.*\///g')

if [[ -z "$ACCOUNT_ID" ]]
then
  ACCOUNT_ID=$ACCOUNT
fi

if [[ ! -z "$MFA" && -z "$SERIAL_NUMBER" ]]
then
  MFA_DEVICE=arn:aws:iam::$ACCOUNT:mfa/$USERNAME
  SERIAL_NUMBER="--serial-number $MFA_DEVICE"
fi

if [[ ! -z "$SERIAL_NUMBER" && -z "$TOKEN_CODE" ]]
then
  read -p "MFA TOKEN: " TOKEN
  TOKEN_CODE="--token-code $TOKEN"
fi


awscli sts assume-role --role-arn arn:aws:iam::${ACCOUNT_ID:-}:role/${ROLE_NAME:-} ${SERIAL_NUMBER:-} ${TOKEN_CODE:-} ${MAX_DURATION:-} --role-session-name $ACCOUNT_ID-$ROLE_NAME-$USERNAME-$RANDOM --output json | jq -r '.Credentials | "export AWS_ACCESS_KEY_ID=" + .AccessKeyId + " AWS_SECRET_ACCESS_KEY=" + .SecretAccessKey + " AWS_SESSION_TOKEN=\"" + .SessionToken + "\" AWS_TOKEN_EXPIRATION=" + .Expiration'
