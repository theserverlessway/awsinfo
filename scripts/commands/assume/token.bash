SERIAL_NUMBER=""
TOKEN_CODE=""
MFA=""

while getopts "ms:t:d:" opt; do
    case "$opt" in
        t) TOKEN_CODE="--token-code $OPTARG" ;;
        s) SERIAL_NUMBER="--serial-number $OPTARG" ;;
        d) MAX_DURATION="--duration-seconds $(expr $OPTARG \* 3600)" ;;
        m) MFA="TRUE" ;;
    esac
done
shift $(($OPTIND-1))

read -r ACCOUNT USERNAME <<<$(awscli sts get-caller-identity --query "[Account, Arn]" --output text | sed 's/arn.*\///g')

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

awscli sts get-session-token ${SERIAL_NUMBER:-} ${TOKEN_CODE:-} ${MAX_DURATION:-} --output json | jq -r '.Credentials | "export AWS_ACCESS_KEY_ID=" + .AccessKeyId + " AWS_SECRET_ACCESS_KEY=" + .SecretAccessKey + " AWS_SESSION_TOKEN=\"" + .SessionToken + "\" AWS_TOKEN_EXPIRATION=" + .Expiration'
