#!/bin/bash

set -euo pipefail

echo "Getting data, ... (filter queues for faster results)"

FILTER_QUERY=""

if [[ $# -gt 1 ]]; then
    echo "Plase provide only one argument to match your queues"
    exit 1
fi

if [[ $# == 1 ]]; then
  FILTER_QUERY="?contains(@,'$1')"
fi

queues=$(awscli sqs list-queues --query "QueueUrls[$FILTER_QUERY]" --output text)

QueueOutput=""
for queue in $queues
do
    QueueOutput+=$(awscli sqs get-queue-attributes --query "Attributes.{\"1.QueueUrl\":'$queue',\"2.MessagesAvailable\":ApproximateNumberOfMessages,\"3.MessagesInFlight,\":ApproximateNumberOfMessagesNotVisible}" --queue-url $queue --attribute-names ApproximateNumberOfMessages ApproximateNumberOfMessagesNotVisible)
    QueueOutput+="\n"
done

echo -e $QueueOutput | python $DIR/combine_calls.py get-queue-attributes