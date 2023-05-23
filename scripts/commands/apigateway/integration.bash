HTTP_REQUEST_METHOD="GET"

while getopts "m:" opt; do
    case "$opt" in
        m) HTTP_REQUEST_METHOD="$OPTARG" ;;
        *) echo "Unsupported Flag" && exit 1
    esac
done
shift $(($OPTIND-1))

source $CURRENT_COMMAND_DIR/resource.sh

echosuccess "Selected HTTPMethod $HTTP_REQUEST_METHOD"

awscli apigateway get-integration --rest-api-id $SELECTED_REST_API --resource-id $SELECTED --http-method $HTTP_REQUEST_METHOD --output table