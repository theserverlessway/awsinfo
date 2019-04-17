function time_parsing() {
    timestamp=$(date --date "$1" +%s)
    if [[ "$?" -ne 0 ]]; then
        exit 1;
    fi
    echo $((timestamp * 1000))
}

function formatted_date() {
    date -Isecond --date @$(($1 / 1000))
}

AWS_LOGS_END_TIME=""
AWS_LOGS_START_TIME=" --start-time $(time_parsing -10minutes) "
AWS_LOGS_FILTER_OPTION=""
AWS_LOGS_FILTER=""

AWS_LOGS_STREAM_PREFIX=""
AWS_LOGS_STREAM_PREFIX_OPTION=""

while getopts "wGSf:s:e:tip:" opt; do
    case "$opt" in
        w) WATCH='FALSE' ;;
        e)
            AWS_LOGS_END_TIME=" --end-time $(time_parsing $OPTARG) "
            WATCH='FALSE'
            ;;
        s) AWS_LOGS_START_TIME=" --start-time $(time_parsing $OPTARG) " ;;
        f)
          AWS_LOGS_FILTER_OPTION="$OPTARG"
          AWS_LOGS_FILTER="--filter-pattern"
          ;;
        p)
          AWS_LOGS_STREAM_PREFIX="$OPTARG"
          AWS_LOGS_STREAM_PREFIX_OPTION="--log-stream-name-prefix"
          ;;
        G) DISABLE_PRINT_GROUP=y ;;
        S) SHOW_PRINT_STREAM=y ;;
        i) PRINT_INGESTION=y ;;
        t) PRINT_TIMESTAMP=y ;;
    esac
done
shift $(($OPTIND-1))

declare -A SEEN

LOG_GROUPS=$(awscli logs describe-log-groups --query "logGroups[$(filter "logGroupName" $@)].[logGroupName]" --output text)
select_one LogGroup "$LOG_GROUPS"
LOG_GROUP=$SELECTED

GROUP_COLOR=$GREEN
STREAM_COLOR=$CYAN
TIMESTAMP_COLOR=$YELLOW
INGESTION_COLOR=$BLUE
NC=$NC

OUTPUT_QUERY=".eventId+\";\"+"
if [[ ! -v DISABLE_PRINT_GROUP ]]; then
    OUTPUT_QUERY+="\"$GROUP_COLOR$LOG_GROUP$NC\",";
fi
if [[ -v SHOW_PRINT_STREAM ]]; then
    OUTPUT_QUERY+="\"$STREAM_COLOR\"+.logStreamName+\"$NC\",";
fi
if [[ -v PRINT_TIMESTAMP ]]; then
    OUTPUT_QUERY+="\"$TIMESTAMP_COLOR\"+((.timestamp/1000)|todate)+\"$NC\",";
fi
if [[ -v PRINT_INGESTION ]]; then
    OUTPUT_QUERY+="\"$INGESTION_COLOR\"+((.ingestionTime/1000)|todate)+\"$NC\",";
fi
OUTPUT_QUERY+=".message"

while true; do
    OUTPUT_STORE=""
    COUNTER=0
    EVENTS=$(awscli logs filter-log-events --log-group-name $LOG_GROUP $AWS_LOGS_STREAM_PREFIX_OPTION $AWS_LOGS_STREAM_PREFIX $AWS_LOGS_START_TIME $AWS_LOGS_END_TIME $AWS_LOGS_FILTER "$AWS_LOGS_FILTER_OPTION" --interleaved --query events[] --output json | jq ".[] | [$OUTPUT_QUERY] | join(\" \") " -cr)

    if [[ ! -z "$EVENTS" ]]
    then
      while read event; do
          IFS=';' read -r eventId message <<< "$event"
          if [[ ! -n "$eventId" || ! -v SEEN["$eventId"] ]]
          then
              SEEN[$eventId]=
              COUNTER=$((COUNTER + 1))
              OUTPUT_STORE+="$message\n"
          fi
      done <<< "$EVENTS"
    fi

    if [[ ! -z "$OUTPUT_STORE" ]]
    then
      echo -ne "$OUTPUT_STORE"
    fi

    if [[ -v WATCH ]]
    then
        exit 0
    else
        sleep 2
        AWS_LOGS_START_TIME=" --start-time $(time_parsing -10minutes) "
    fi
done
