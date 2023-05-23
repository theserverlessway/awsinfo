HTTP_REQUEST_METHOD="GET"
HTTP_STATUS_CODE="200"

while getopts "m:s:" opt; do
    case "$opt" in
        m) HTTP_REQUEST_METHOD="$OPTARG" ;;
        s) HTTP_STATUS_CODE="$OPTARG" ;;
        *) echo "Unsupported Flag" && exit 1
    esac
done
shift $(($OPTIND-1))

source $CURRENT_COMMAND_DIR/resource.sh

echosuccess "Selected HTTPMethod $HTTP_REQUEST_METHOD"

awscli apigateway get-method-response --rest-api-id "$SELECTED_REST_API" --resource-id "$SELECTED" --http-method "$HTTP_REQUEST_METHOD" --status-code "$HTTP_STATUS_CODE" --output table