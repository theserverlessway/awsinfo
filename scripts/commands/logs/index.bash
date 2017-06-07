#!/bin/bash

set -euo pipefail

function time_parsing() {
    timestamp=$(date --date "$1" +%s)
    echo $((timestamp * 1000))
}

function formatted_date() {
    date -Isecond --date @$(($1 / 1000))
}


# Loading options

SHORT=wGSf:s:e:ti

# -temporarily store output to be able to check for errors
# -activate advanced mode getopt quoting e.g. via “--options”
# -pass arguments only via   -- "$@"   to separate them correctly
PARSED=$(getopt --options $SHORT --name "$0" -- "$@")
if [[ $? -ne 0 ]]; then
    # e.g. $? == 1
    #  then getopt has complained about wrong arguments to stdout
    exit 2
fi
# use eval with "$PARSED" to properly handle the quoting
eval set -- "$PARSED"

AWS_LOGS_END_TIME=""
AWS_LOGS_START_TIME=" --start-time $(time_parsing -10minutes) "
AWS_LOGS_FILTER=""

# now enjoy the options in order and nicely split until we see --
while true; do
    case "$1" in
        -w)
            WATCH=y
            shift
        ;;
        -e)
            AWS_LOGS_END_TIME=" --end-time $(time_parsing $2) "
            shift 2
        ;;
        -s)
            AWS_LOGS_START_TIME=" --start-time $(time_parsing $2) "
            shift 2
        ;;
        -f)
            AWS_LOGS_FILTER=" --filter-pattern \"$2\""
            shift 2
        ;;
        -G)
            DISABLE_PRINT_GROUP=y
            shift
        ;;
        -S)
            DISABLE_PRINT_STREAM=y
            shift
        ;;
        -i | --ingestion-time)
            PRINT_INGESTION=y
            shift
        ;;
        -t | --timestamp)
            PRINT_TIMESTAMP=y
            shift
        ;;
        --)
            shift
            break
        ;;
        *)
            echo "Programming error"
            exit 3
        ;;
    esac
done

declare -A SEEN

function now() {
    echo $((`date -u +%s` * 1000))
}

function before() {
    echo $((`date -u +%s` * 1000 - 15 * $MINUTE))
}

BEGINNING=$(before)
END=$(now)

LOG_GROUPS=$(awscli logs describe-log-groups --query "logGroups[$(filter "logGroupName" $@)].[logGroupName]" --output text)
if [[ $(echo "$LOG_GROUPS" | grep -c '[^[:space:]]') != 1 ]]
then
    echo "Make sure the LogGroup parameter matches exactly one LogGroup"
    echo "$LOG_GROUPS"
    exit 1
else
    LOG_GROUP="$LOG_GROUPS"
fi

GROUP_COLOR='\\033[0;32m'
STREAM_COLOR='\\033[0;36m'
TIMESTAMP_COLOR='\\033[0;33m'
INGESTION_COLOR='\\033[0;34m'
NC='\\033[0m'

while true; do
    while read -r event; do
        eventId=$(echo $event | jq .eventId -r)
        if [[ ! -n "$eventId" || ! -v SEEN["$eventId"] ]]
        then
            SEEN[$eventId]=
            OUTPUT_QUERY=""

            if [[ ! -v DISABLE_PRINT_GROUP ]]; then
                OUTPUT_QUERY+="\"$GROUP_COLOR$LOG_GROUP$NC\",";
            fi
            if [[ ! -v DISABLE_PRINT_STREAM ]]; then
                OUTPUT_QUERY+="\"$STREAM_COLOR\"+.logStreamName+\"$NC\",";
            fi
            if [[ -v PRINT_TIMESTAMP ]]; then
                OUTPUT_QUERY+="\"$TIMESTAMP_COLOR\"+((.timestamp/1000)|todate)+\"$NC\",";
            fi
            if [[ -v PRINT_INGESTION ]]; then
                OUTPUT_QUERY+="\"$INGESTION_COLOR\"+((.ingestionTime/1000)|todate)+\"$NC\",";
            fi
            OUTPUT_QUERY+=".message"
            echo -e $(echo "$event" | jq ". | [$OUTPUT_QUERY] | join(\" \")" -c -r)
        fi
    done < <( awscli logs filter-log-events --log-group-name $LOG_GROUP $AWS_LOGS_START_TIME $AWS_LOGS_END_TIME $AWS_LOGS_FILTER --interleaved --query events[] | jq .[] -c)

    if [[ -v WATCH ]]
    then
        sleep 2
    else
        exit 0
    fi
done

trap "trap - SIGTERM && kill---$$" SIGINT SIGTERM EXIT
