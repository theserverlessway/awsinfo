# `awsinfo ecs tasks [-s] [cluster-filter]* -- [task-filter]*`

List all running tasks for a Cluster sorted by Task Definition name and CreatedAt Timestamp. Only shows up to 100 tasks, use `-f` or `-n` to filter for family or name of service for shorter list.

## Options

* `-s`: List stopped tasks
* `-f`: Show tasks from that family
* `-n`: Show Tasks for that service name only

## First filter matches against

* Cluster Name

## Second filter matches against

* Task Arn
* TaskDefinitionArn
* ContainerInstanceArn
* LastStatus
* Group
* Cpu
* Memory
* LaunchType
