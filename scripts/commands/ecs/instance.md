# `awsinfo ecs instance -f "CLUSTER_FILTER_EXPRESSION" [cluster-filter]* -- [instance-filter]*`

Describe a cluster instance.

With `-f` you can use a ECS cluster query (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cluster-query-language.html)
to select an instance (on top of just selecting it with a filter on the Container Instance ID). This is helpful
if you want to filter on attributes.

## First filter matches against

* Cluster Name

## Second filter matches against

* Container Instance Id
