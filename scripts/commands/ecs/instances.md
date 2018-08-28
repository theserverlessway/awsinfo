# `awsinfo ecs instances  -f "CLUSTER_FILTER_EXPRESSION" [cluster-filter]* -- [instance-filter]*`

List up to 100 instances for the specified cluster. If you have >100 instances use `-f` to filter which instances
AWS returns.

With `-f` you can use a ECS cluster query (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cluster-query-language.html)
to select an instance. This can also be helpful if the built-in filtering doesn't suffice, on top of the ability
to limit the number of returned instances from AWS.

## First filter matches against

* Cluster Name

## Second filter matches against

* Container Instance Arn
* EC2 Instance Id
* Status
* Agent Connected
* All Attribute Values
