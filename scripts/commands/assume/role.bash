while getopts "s:t:d:a:r:" opt; do
    case "$opt" in
        t) TOKEN_CODE="--token-code $OPTARG" ;;
        s) SERIAL_NUMBER="--serial-number $OPTARG" ;;
        d) MAX_DURATION="--duration-seconds $(expr $OPTARG \* 3600)" ;;
        a) ACCOUNT_ID="$OPTARG" ;;
        r) ROLE_NAME="$OPTARG" ;;
    esac
done
shift $(($OPTIND-1))

awscli sts assume-role --role-arn arn:aws:iam::$ACCOUNT_ID:role/$ROLE_NAME ${SERIAL_NUMBER:-} ${TOKEN_CODE:-} ${MAX_DURATION:-} --role-session-name $ACCOUNT_ID-$ROLE_NAME-$RANDOM --output json | jq -r '.Credentials | "export AWS_ACCESS_KEY_ID=" + .AccessKeyId + " AWS_SECRET_ACCESS_KEY=" + .SecretAccessKey + " AWS_SESSION_TOKEN=\"" + .SessionToken + "\" AWS_TOKEN_EXPIRATION=" + .Expiration'