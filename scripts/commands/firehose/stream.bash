DELIVERY_STREAMS=$(awscli firehose list-delivery-streams --limit 5000 --output text --query "DeliveryStreamNames[$(auto_filter_joined @ -- $@)].[@]")

select_one DeliveryStream "$DELIVERY_STREAMS"

awscli firehose describe-delivery-stream --delivery-stream-name "$SELECTED" --output table --query "DeliveryStreamDescription"