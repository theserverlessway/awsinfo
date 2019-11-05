function time_parsing() {
    timestamp=$(awsinfo_date --date "$1" +%s)
    if [[ "$?" -ne 0 ]]; then
        exit 1;
    fi
    echo $((timestamp * 1000))
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

split_args "$@"

LOG_GROUPS=$(awscli logs describe-log-groups --query "logGroups[$(filter "logGroupName" $FIRST_RESOURCE)].[logGroupName]" --output text)
select_one LogGroup "$LOG_GROUPS"
LOG_GROUP=$SELECTED

LOG_STREAMS_FILTER=""

if [[ $SECOND_RESOURCE =~ .*[a-zA-Z0-9]+.* ]]
then
  LOG_STREAMS=$(awscli logs describe-log-streams --log-group-name $SELECTED --query "logStreams[$(auto_filter logStreamName -- $SECOND_RESOURCE)].logStreamName" --output text)
  if [[ ! -z "$LOG_STREAMS" ]]
  then
    LOG_STREAMS_FILTER="--log-stream-names $LOG_STREAMS"
    echosuccess "Selected LogStreams:"
    for stream in $LOG_STREAMS
     do
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
    EVENTS=$(awscli logs filter-log-events $LOG_STREAMS_FILTER --log-group-name $LOG_GROUP $AWS_LOGS_STREAM_PREFIX_OPTION $AWS_LOGS_STREAM_PREFIX $AWS_LOGS_START_TIME $AWS_LOGS_END_TIME $AWS_LOGS_FILTER "$AWS_LOGS_FILTER_OPTION" --query events[] --output json | jq ".[] | [$OUTPUT_QUERY] | join(\" \") " -cr)

    if [[ ! -z "$EVENTS" ]]
    then
      while read event; do
          IFS=';' read -r eventId message <<< "$event"
          if [[ -n "$eventId" && ! -v SEEN["$eventId"] && ! -z "$message" ]]
          then
              SEEN[$eventId]=
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
        break
    else
        sleep 2
        # Limit the starting time after first run so we're not loading lots of events. We can't set it to now
        # as otherwise if events are ingested late they might not be picked up.
        # Disabled for now as setting it to a large value is an issue when setting a Starting Time of < 10 minutes
        # as it will first print events with the starting date, but then add new ones fromt eh now longer ago starting time.
        # Needs to be addressed with a better fix in the future
        # AWS_LOGS_START_TIME=" --start-time $(time_parsing -10minutes) "
    fi
done
