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
    *) echo "Unsupported Flag" && exit 1 ;;
    esac
done
shift $(($OPTIND - 1))

declare -A SEEN

split_args "$@"

LOG_GROUPS=$(awscli logs describe-log-groups --query "logGroups[$(auto_filter_joined "logGroupName" -- $FIRST_RESOURCE)].[logGroupName]" --output text)
select_one LogGroup "$LOG_GROUPS"
LOG_GROUP=$SELECTED

LOG_STREAMS_FILTER=""

if [[ $SECOND_RESOURCE =~ .*[a-zA-Z0-9]+.* ]]; then
    LOG_STREAMS=$(awscli logs describe-log-streams --log-group-name "$SELECTED" --query "logStreams[$(auto_filter_joined logStreamName -- "$SECOND_RESOURCE")].logStreamName" --output text)
    if [[ ! -z "$LOG_STREAMS" ]]; then
        LOG_STREAMS_FILTER="--log-stream-names $LOG_STREAMS"
        echosuccess "Selected LogStreams:"
        for stream in $LOG_STREAMS; do
            echoinfomsg "  $stream"
        done
    else
        echoerr "No Log Streams matching filters found"
    fi
fi

GROUP_COLOR=$GREEN
STREAM_COLOR=$CYAN
TIMESTAMP_COLOR=$YELLOW
INGESTION_COLOR=$BLUE
NC=$NC

OUTPUT_QUERY=".eventId+\";\"+"
if [[ ! -v DISABLE_PRINT_GROUP ]]; then
    OUTPUT_QUERY+="\"$GROUP_COLOR$LOG_GROUP$NC\","
fi
if [[ -v SHOW_PRINT_STREAM ]]; then
    OUTPUT_QUERY+="\"$STREAM_COLOR\"+.logStreamName+\"$NC\","
fi
if [[ -v PRINT_TIMESTAMP ]]; then
    OUTPUT_QUERY+="\"$TIMESTAMP_COLOR\"+((.timestamp/1000)|todate)+\"$NC\","
fi
if [[ -v PRINT_INGESTION ]]; then
    OUTPUT_QUERY+="\"$INGESTION_COLOR\"+((.ingestionTime/1000)|todate)+\"$NC\","
fi
OUTPUT_QUERY+=".message"

while true; do
    OUTPUT_STORE=""
    EVENTS="$(awscli logs filter-log-events $LOG_STREAMS_FILTER --log-group-name $LOG_GROUP $AWS_LOGS_STREAM_PREFIX_OPTION $AWS_LOGS_STREAM_PREFIX $AWS_LOGS_START_TIME $AWS_LOGS_END_TIME $AWS_LOGS_FILTER "$AWS_LOGS_FILTER_OPTION" --query events[] --output json | jq ".[] | [$OUTPUT_QUERY] | join(\" \") " -cr)"
    if [[ ! -z "$EVENTS" ]]; then
        while read -r event; do
            IFS=';' read -r eventId message <<<"${event}"
            if [[ -n "$eventId" && ! -v SEEN["$eventId"] && ! -z "$message" ]]; then
                SEEN[$eventId]=
                printf "%s\n" "$message"
            fi
        done <<<"${EVENTS}"
    fi

    if [[ -v WATCH ]]; then
        break
    else
        sleep 2
        # Limit the starting time after first run so we're not loading lots of events. We can't set it to now
        # as otherwise if events are ingested late they might not be picked up. The timestamp used in the
        # AWSCli call is not based on the ingestion timestamp, but the timestamp an event occured. Thus
        # if we set it to now or too close to the current time some events with older timestamps might be ingested
        # late and therefore not found.
        AWS_LOGS_NEW_START_TIME=" --start-time $(time_parsing -2minutes) "
        if [[ "$AWS_LOGS_START_TIME" < "$AWS_LOGS_NEW_START_TIME" ]]; then
            AWS_LOGS_START_TIME="$AWS_LOGS_NEW_START_TIME"
        fi
    fi
done
