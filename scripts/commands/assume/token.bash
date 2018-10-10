while getopts "s:t:d:" opt; do
    case "$opt" in
        t) TOKEN_CODE="--token-code $OPTARG" ;;
        s) SERIAL_NUMBER="--serial-number $OPTARG" ;;
        d) MAX_DURATION="--duration-seconds $(expr $OPTARG \* 3600)" ;;
    esac
done
shift $(($OPTIND-1))

awscli sts get-session-token ${SERIAL_NUMBER:-} ${TOKEN_CODE:-} ${MAX_DURATION:-} --output json | jq -r '.Credentials | "export AWS_ACCESS_KEY_ID=" + .AccessKeyId + " AWS_SECRET_ACCESS_KEY=" + .SecretAccessKey + " AWS_SESSION_TOKEN=\"" + .SessionToken + "\" AWS_TOKEN_EXPIRATION=" + .Expiration'
