echo "Getting data, ... (filter queues for faster results)"

FILTER_QUERY=$(filter "@" "$@")

queues=$(awscli sqs list-queues --query "QueueUrls[$FILTER_QUERY]" --output text | sed s/^None//g)

QueueOutput=""
for queue in $queues
do
    QueueOutput+=$(awscli sqs get-queue-attributes --query "Attributes.{\"1.QueueUrl\":'$queue',\"2.MessagesAvailable\":ApproximateNumberOfMessages,\"3.MessagesInFlight,\":ApproximateNumberOfMessagesNotVisible}" --queue-url $queue --attribute-names ApproximateNumberOfMessages ApproximateNumberOfMessagesNotVisible)
    QueueOutput+="\n"
done

echo -e $QueueOutput | print_table GetQueueAttributes