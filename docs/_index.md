---
title: AWSInfo
subtitle: The AWS Console in your Terminal
weight: 200
disable_pagination: true
---

{{< vimeo 236898402 >}}

`awsinfo` is a read-only client for AWS written in Bash. It tries to replace the AWS console for getting basic information about your AWS resoures in your CLI. No more opening the AWS Console when all you want to know is basic information about your resources.

## Why a read-only AWS Client
When we try to get the most out of AWS by building on top of as many AWS services as possible we regularly have to look up information about our resources. From checking the deploment status of a CloudFormation stack to the number of messages in an SQS Queue, the status of a CodeBuild Project or the number of EC2 instances currently running.

Looking up this information often requires us to go through the AWS Console as the CLI tooling that AWS provides is a great interface to their API, but hard to use for getting an overview on deployed resources quickly. `awsinfo` provides you with default views, similar to the AWS Console, for various (and growing) AWS services so you can get the most important information. While `awsinfo` provides you with some access to deeper information on specific services, for the most part once you want to dig really deep other tools like the `awscli` or `aws-shell` are great for exploring all the details.

## Why Bash

Terminals are the most common piece of tech we all use, regardless of the specific language we prefer. By building `awsinfo` as a collection of bash scripts you can easily see and understand how it works under the hood. If it doesn't do exactly what you need it to do you can copy the script, edit it to do exactly what you need and add that to your repository or local bash.

This is much more complicated if this tool were built on any specific programming language as we'd have to understand a lot more of the environment to get it up and running.

Building it with Bash also means we can use the `awscli` directly which removes a lot of necessary implementation.

## Installation

While you can simply clone the repository and run the `awsinfo.bash` file directly (e.g. by putting it into your `PATH`) the preferred method of installation is going through Docker. This allows tight control over everything that is used in `awsinfo` (e.g. Bash Version or other tools that need to be available like gnu time) while making it easy for you to install and use. In case you install `awsinfo` by cloning the repo make sure you have Bash 4 and the `awscli` installed. Some commands might need specific cli tools as well, check the `Dockerfile` for all the tools that are installed.

### Using Docker directly

You can use the following command to use the `awsinfo` Docker container with pure Docker. It will automatically download it and run the container for you with any Arguments you append at the end. It makes the `~/.aws` folder accessible as a Volume as well as forwarding all `awscli` default environment variables.

```bash
docker run -it -v ~/.aws:/root/.aws -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN -e AWS_DEFAULT_REGION -e AWS_PROFILE -e AWS_CONFIG_FILE -e AWSINFO_DEBUG flomotlik/awsinfo ARGUMENTS_FOR_AWSINFO
```

You can set it up as an alias in your shell config file as well.

```bash
alias awsinfo='docker run -it -v ~/.aws:/root/.aws -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN -e AWS_DEFAULT_REGION -e AWS_PROFILE -e AWS_CONFIG_FILE -e AWSINFO_DEBUG flomotlik/awsinfo'
```

### Whalebrew

If you're using [Whalebrew](https://github.com/bfirsh/whalebrew)(Which I highly recommend) simply run the following to install:

```bash
whalebrew install flomotlik/awsinfo
```

## Update

To update the Docker container run `docker pull flomotlik/awsinfo:latest`

## Usage

`awsinfo` commands support commands and subcommands, for example you can run `awsinfo logs` to print log messages
or `awsinfo logs groups` to get a list of all log groups in the current account and region.

To see all supported services check out the following list or run `awsinfo commands`.
You can see all the available commands for a service by running `awsinfo commands SERVICE`, e.g.
`awsinfo commands ec2`.

You can run any command with `--help` (e.g. `awsinfo logs --help`) to see the same help
page that is in the repo (and linked below).

## Supported Services and Commands

You can list all supported services with `awsinfo commands` and get a list of all commands per service with `awsinfo command SERVICE`, e.g. `awsinfo command ec2`

Following is a list of all available commands and links to their source documentation files that are also used when you call a command with `--help`

### Commands

* [`acm `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/acm/index.md)
* [`appsync `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/appsync/index.md)
* [`appsync datasources`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/appsync/datasources.md)
* [`appsync resolvers`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/appsync/resolvers.md)
* [`appsync schema`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/appsync/schema.md)
* [`appsync types`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/appsync/types.md)
* [`assume `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/assume/index.md)
* [`assume role`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/assume/role.md)
* [`assume token`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/assume/token.md)
* [`batch `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/batch/index.md)
* [`batch compute-environment`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/batch/compute-environment.md)
* [`batch compute-environments`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/batch/compute-environments.md)
* [`batch job-queues`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/batch/job-queues.md)
* [`batch jobs`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/batch/jobs.md)
* [`cfn `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/cfn/index.md)
* [`cfn change-set`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/cfn/change-set.md)
* [`cfn change-sets`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/cfn/change-sets.md)
* [`cfn events`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/cfn/events.md)
* [`cfn exports`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/cfn/exports.md)
* [`cfn imports`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/cfn/imports.md)
* [`cfn outputs`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/cfn/outputs.md)
* [`cfn policy`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/cfn/policy.md)
* [`cfn resources`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/cfn/resources.md)
* [`cfn stack-set-instances`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/cfn/stack-set-instances.md)
* [`cfn stack-set-operations`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/cfn/stack-set-operations.md)
* [`cfn stack-set-template`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/cfn/stack-set-template.md)
* [`cfn stack-set`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/cfn/stack-set.md)
* [`cfn stack-sets`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/cfn/stack-sets.md)
* [`cfn stack`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/cfn/stack.md)
* [`cfn template`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/cfn/template.md)
* [`cloudfront `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/cloudfront/index.md)
* [`cloudfront origins`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/cloudfront/origins.md)
* [`cloudwatch alarms`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/cloudwatch/alarms.md)
* [`cognito `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/cognito/index.md)
* [`cognito clients`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/cognito/clients.md)
* [`cognito users`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/cognito/users.md)
* [`commands `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/commands/index.md)
* [`complete `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/complete/index.md)
* [`credentials `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/credentials/index.md)
* [`dynamodb `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/dynamodb/index.md)
* [`dynamodb table`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/dynamodb/table.md)
* [`ec2 `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/ec2/index.md)
* [`ec2 keys`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/ec2/keys.md)
* [`ec2 network-interface`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/ec2/network-interface.md)
* [`ec2 network-interfaces`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/ec2/network-interfaces.md)
* [`ec2 security-group`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/ec2/security-group.md)
* [`ec2 security-groups`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/ec2/security-groups.md)
* [`ec2 vpc-endpoint-services`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/ec2/vpc-endpoint-services.md)
* [`ecr `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/ecr/index.md)
* [`ecr images`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/ecr/images.md)
* [`ecs `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/ecs/index.md)
* [`ecs instance`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/ecs/instance.md)
* [`ecs instances`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/ecs/instances.md)
* [`ecs service`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/ecs/service.md)
* [`ecs services`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/ecs/services.md)
* [`ecs task-definition`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/ecs/task-definition.md)
* [`ecs task-definitions`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/ecs/task-definitions.md)
* [`ecs task-families`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/ecs/task-families.md)
* [`ecs task`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/ecs/task.md)
* [`ecs tasks`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/ecs/tasks.md)
* [`efs `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/efs/index.md)
* [`efs mount-targets`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/efs/mount-targets.md)
* [`efs security-groups`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/efs/security-groups.md)
* [`elasticbeanstalk `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/elasticbeanstalk/index.md)
* [`elasticbeanstalk applications`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/elasticbeanstalk/applications.md)
* [`elasticbeanstalk events`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/elasticbeanstalk/events.md)
* [`elasticbeanstalk health`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/elasticbeanstalk/health.md)
* [`elasticbeanstalk instances`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/elasticbeanstalk/instances.md)
* [`elasticbeanstalk stacks`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/elasticbeanstalk/stacks.md)
* [`elasticbeanstalk versions`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/elasticbeanstalk/versions.md)
* [`elb `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/elb/index.md)
* [`elb listener`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/elb/listener.md)
* [`elb listeners`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/elb/listeners.md)
* [`elb old`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/elb/old.md)
* [`elb rules`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/elb/rules.md)
* [`elb target-group`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/elb/target-group.md)
* [`elb target-groups`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/elb/target-groups.md)
* [`elb targets`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/elb/targets.md)
* [`es `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/es/index.md)
* [`es domain`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/es/domain.md)
* [`events `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/events/index.md)
* [`events targets`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/events/targets.md)
* [`iam `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/iam/index.md)
* [`iam aws-policies`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/iam/aws-policies.md)
* [`iam group-policies`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/iam/group-policies.md)
* [`iam group-policy`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/iam/group-policy.md)
* [`iam groups`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/iam/groups.md)
* [`iam instance-profiles`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/iam/instance-profiles.md)
* [`iam mfa`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/iam/mfa.md)
* [`iam policies`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/iam/policies.md)
* [`iam policy-version`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/iam/policy-version.md)
* [`iam role-policies`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/iam/role-policies.md)
* [`iam role-policy`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/iam/role-policy.md)
* [`iam role`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/iam/role.md)
* [`iam roles`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/iam/roles.md)
* [`iam user-policies`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/iam/user-policies.md)
* [`iam user-policy`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/iam/user-policy.md)
* [`iam users`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/iam/users.md)
* [`kms `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/kms/index.md)
* [`kms aliases`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/kms/aliases.md)
* [`lambda `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/lambda/index.md)
* [`lambda function`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/lambda/function.md)
* [`lambda function`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/lambda/function.md)
* [`logs `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/logs/index.md)
* [`logs groups`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/logs/groups.md)
* [`logs streams`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/logs/streams.md)
* [`me `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/me/index.md)
* [`orgs `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/orgs/index.md)
* [`rds `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/rds/index.md)
* [`rds cluster`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/rds/cluster.md)
* [`rds clusters`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/rds/clusters.md)
* [`rds engine-versions`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/rds/engine-versions.md)
* [`rds instance`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/rds/instance.md)
* [`route53 `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/route53/index.md)
* [`route53 records`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/route53/records.md)
* [`s3 acl`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/s3/acl.md)
* [`s3 encryption`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/s3/encryption.md)
* [`s3 lifecycle`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/s3/lifecycle.md)
* [`s3 location`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/s3/location.md)
* [`s3 notifications`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/s3/notifications.md)
* [`s3 policy`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/s3/policy.md)
* [`s3 website`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/s3/website.md)
* [`secretsmanager `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/secretsmanager/index.md)
* [`secretsmanager policy`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/secretsmanager/policy.md)
* [`secretsmanager secret`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/secretsmanager/secret.md)
* [`secretsmanager value`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/secretsmanager/value.md)
* [`ses `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/ses/index.md)
* [`sns `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/sns/index.md)
* [`sns subscriptions`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/sns/subscriptions.md)
* [`sqs `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/sqs/index.md)
* [`ssm `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/ssm/index.md)
* [`ssm parameter`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/ssm/parameter.md)
* [`version `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/version/index.md)
* [`vpc `](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/vpc/index.md)
* [`vpc nat-gateways`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/vpc/nat-gateways.md)
* [`vpc route-tables`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/vpc/route-tables.md)
* [`vpc subnets`](https://github.com/flomotlik/awsinfo/blob/master/scripts/commands/vpc/subnets.md)