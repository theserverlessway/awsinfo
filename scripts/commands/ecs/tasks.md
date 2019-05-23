# `awsinfo ecs tasks [-s] [cluster-filter]* -- [task-filter]*`

List all running tasks for a Cluster sorted by Task Definition name and CreatedAt Timestamp.

## Options

* `-s`: List stopped tasks

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
