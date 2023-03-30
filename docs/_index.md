---
title: AWSInfo
subtitle: The AWS Console in your Terminal
weight: 200
disable_pagination: true
---

{{< vimeo 358865451 >}}

`awsinfo` is a read-only client for AWS written in Bash. It tries to replace the AWS console for getting basic information about your AWS resoures in your CLI. No more opening the AWS Console when all you want to know is basic information about your resources.

## Why a read-only AWS Client
When we try to get the most out of AWS by building on top of as many AWS services as possible we regularly have to look up information about our resources. From checking the deploment status of a CloudFormation stack to the number of messages in an SQS Queue, the status of a CodeBuild Project or the number of EC2 instances currently running.

Looking up this information often requires us to go through the AWS Console as the CLI tooling that AWS provides is a great interface to their API, but hard to use for getting an overview on deployed resources quickly. `awsinfo` provides you with default views, similar to the AWS Console, for various (and growing) AWS services so you can get the most important information. While `awsinfo` provides you with some access to deeper information on specific services, for the most part once you want to dig really deep other tools like the `awscli` or `aws-shell` are great for exploring all the details.

## Why Bash

Terminals are the most common piece of tech we all use, regardless of the specific language we prefer. By building `awsinfo` as a collection of bash scripts you can easily see and understand how it works under the hood. If it doesn't do exactly what you need it to do you can copy the script, edit it to do exactly what you need and add that to your repository or local bash.

This is much more complicated if this tool were built on any specific programming language as we'd have to understand a lot more of the environment to get it up and running.

Building it with Bash also means we can use the `awscli` directly which removes a lot of necessary implementation.

## Installation

You can run AWSInfo either directly as a script or install through Docker.

## Use directly as a script

On OSX you need to make sure that you have a recent version of Bash (>4) and the GNU coreutils installed, specifically `greadlink` and `gdate`. You can install them for example with `brew install bash coreutils`. On Linux this should just work.

After that clone the Repository and either softlink the `scripts/awsinfo.bash` script or put it in your Path. You can then directly execute the script as it automatically detects the path it was cloned into. For updates just pull from the Repository.

On Linux or Windows Subsystem for Linux, you might want to clone the repo to `/usr/local/bin/awsinfo.git` or `$HOME/bin/awsinfo.git` and then `cd /usr/local/bin && ln -s awsinfo.git/scripts/awsinfo.bash awsinfo` or `cd $HOME/bin && ln -s awsinfo.git/scripts/awsinfo.bash awsinfo`.

AWSInfo needs the following tools installed on your system:

* [awscli](https://docs.aws.amazon.com/de_de/cli/latest/userguide/cli-chap-install.html)
* [jq](https://stedolan.github.io/jq/)

### Using Docker directly

You can use the following command to use the `awsinfo` Docker container with pure Docker. It will automatically download it and run the container for you with any Arguments you append at the end. It makes the `~/.aws` folder accessible as a Volume as well as forwarding all `awscli` default environment variables.

```bash
docker run -it -v ~/.aws:/root/.aws -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN -e AWS_DEFAULT_REGION -e AWS_PROFILE -e AWS_CONFIG_FILE -e AWSINFO_DEBUG theserverlessway/awsinfo ARGUMENTS_FOR_AWSINFO
```

You can set it up as an alias in your shell config file as well.

```bash
alias awsinfo='docker run -it -v ~/.aws:/root/.aws -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN -e AWS_DEFAULT_REGION -e AWS_PROFILE -e AWS_CONFIG_FILE -e AWSINFO_DEBUG theserverlessway/awsinfo'
```

### Whalebrew

If you're using [Whalebrew](https://github.com/bfirsh/whalebrew)(Which I highly recommend) simply run the following to install:

```bash
whalebrew install theserverlessway/awsinfo
```

## Update

To update the Docker container run `docker pull theserverlessway/awsinfo:latest`

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

* [`acm`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/acm/index.md)
* [`acm certificate`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/acm/certificate.md)
* [`appautoscaling`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/appautoscaling/index.md)
* [`appautoscaling policies`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/appautoscaling/policies.md)
* [`appautoscaling policy`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/appautoscaling/policy.md)
* [`appautoscaling schedules`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/appautoscaling/schedules.md)
* [`appautoscaling targets`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/appautoscaling/targets.md)
* [`appsync`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/appsync/index.md)
* [`appsync datasources`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/appsync/datasources.md)
* [`appsync resolvers`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/appsync/resolvers.md)
* [`appsync schema`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/appsync/schema.md)
* [`appsync types`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/appsync/types.md)
* [`assume`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/assume/index.md)
* [`assume role`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/assume/role.md)
* [`assume token`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/assume/token.md)
* [`autoscaling`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/autoscaling/index.md)
* [`autoscaling group`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/autoscaling/group.md)
* [`batch`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/batch/index.md)
* [`batch compute-environment`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/batch/compute-environment.md)
* [`batch compute-environments`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/batch/compute-environments.md)
* [`batch job-queues`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/batch/job-queues.md)
* [`batch jobs`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/batch/jobs.md)
* [`budgets`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/budgets/index.md)
* [`budgets budget`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/budgets/budget.md)
* [`cloudformation`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/cloudformation/index.md)
* [`cloudformation change-set`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/cloudformation/change-set.md)
* [`cloudformation change-sets`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/cloudformation/change-sets.md)
* [`cloudformation events`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/cloudformation/events.md)
* [`cloudformation exports`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/cloudformation/exports.md)
* [`cloudformation imports`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/cloudformation/imports.md)
* [`cloudformation outputs`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/cloudformation/outputs.md)
* [`cloudformation policy`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/cloudformation/policy.md)
* [`cloudformation resources`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/cloudformation/resources.md)
* [`cloudformation stack`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/cloudformation/stack.md)
* [`cloudformation stack-set`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/cloudformation/stack-set.md)
* [`cloudformation stack-set-instances`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/cloudformation/stack-set-instances.md)
* [`cloudformation stack-set-operations`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/cloudformation/stack-set-operations.md)
* [`cloudformation stack-set-template`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/cloudformation/stack-set-template.md)
* [`cloudformation stack-sets`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/cloudformation/stack-sets.md)
* [`cloudformation template`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/cloudformation/template.md)
* [`cloudfront`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/cloudfront/index.md)
* [`cloudfront distribution`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/cloudfront/distribution.md)
* [`cloudfront origins`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/cloudfront/origins.md)
* [`cloudwatch alarms`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/cloudwatch/alarms.md)
* [`codebuild`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/codebuild/index.md)
* [`codebuild build`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/codebuild/build.md)
* [`codebuild builds`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/codebuild/builds.md)
* [`codecommit`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/codecommit/index.md)
* [`codecommit branches`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/codecommit/branches.md)
* [`codecommit pull-request`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/codecommit/pull-request.md)
* [`codecommit pull-requests`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/codecommit/pull-requests.md)
* [`codecommit repository`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/codecommit/repository.md)
* [`codepipeline`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/codepipeline/index.md)
* [`codepipeline action-executions`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/codepipeline/action-executions.md)
* [`codepipeline actions`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/codepipeline/actions.md)
* [`codepipeline execution`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/codepipeline/execution.md)
* [`codepipeline executions`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/codepipeline/executions.md)
* [`codepipeline stage`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/codepipeline/stage.md)
* [`codepipeline state`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/codepipeline/state.md)
* [`cognito`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/cognito/index.md)
* [`cognito clients`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/cognito/clients.md)
* [`cognito users`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/cognito/users.md)
* [`commands`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/commands/index.md)
* [`complete`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/complete/index.md)
* [`complete zsh`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/complete/zsh.md)
* [`costs`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/costs/index.md)
* [`costs service`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/costs/service.md)
* [`costs services`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/costs/services.md)
* [`costs usage`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/costs/usage.md)
* [`credentials`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/credentials/index.md)
* [`dynamodb`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/dynamodb/index.md)
* [`dynamodb table`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/dynamodb/table.md)
* [`ec2`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/ec2/index.md)
* [`ec2 images`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/ec2/images.md)
* [`ec2 instance`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/ec2/instance.md)
* [`ec2 keys`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/ec2/keys.md)
* [`ecr`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/ecr/index.md)
* [`ecr images`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/ecr/images.md)
* [`ecs`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/ecs/index.md)
* [`ecs instance`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/ecs/instance.md)
* [`ecs instances`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/ecs/instances.md)
* [`ecs service`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/ecs/service.md)
* [`ecs service-events`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/ecs/service-events.md)
* [`ecs services`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/ecs/services.md)
* [`ecs task`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/ecs/task.md)
* [`ecs task-definition`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/ecs/task-definition.md)
* [`ecs task-definitions`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/ecs/task-definitions.md)
* [`ecs task-families`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/ecs/task-families.md)
* [`ecs tasks`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/ecs/tasks.md)
* [`efs`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/efs/index.md)
* [`efs file-system`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/efs/file-system.md)
* [`efs mount-targets`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/efs/mount-targets.md)
* [`efs security-groups`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/efs/security-groups.md)
* [`elasticbeanstalk`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/elasticbeanstalk/index.md)
* [`elasticbeanstalk applications`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/elasticbeanstalk/applications.md)
* [`elasticbeanstalk events`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/elasticbeanstalk/events.md)
* [`elasticbeanstalk health`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/elasticbeanstalk/health.md)
* [`elasticbeanstalk instances`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/elasticbeanstalk/instances.md)
* [`elasticbeanstalk stacks`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/elasticbeanstalk/stacks.md)
* [`elasticbeanstalk versions`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/elasticbeanstalk/versions.md)
* [`elb`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/elb/index.md)
* [`elb listener`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/elb/listener.md)
* [`elb listener-certificates`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/elb/listener-certificates.md)
* [`elb listeners`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/elb/listeners.md)
* [`elb old`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/elb/old.md)
* [`elb rules`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/elb/rules.md)
* [`elb target-group`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/elb/target-group.md)
* [`elb target-groups`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/elb/target-groups.md)
* [`elb targets`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/elb/targets.md)
* [`es`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/es/index.md)
* [`es domain`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/es/domain.md)
* [`events`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/events/index.md)
* [`events targets`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/events/targets.md)
* [`firehose`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/firehose/index.md)
* [`firehose stream`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/firehose/stream.md)
* [`iam`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/iam/index.md)
* [`iam attached-group-policies`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/iam/attached-group-policies.md)
* [`iam attached-role-policies`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/iam/attached-role-policies.md)
* [`iam attached-user-policies`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/iam/attached-user-policies.md)
* [`iam aws-policies`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/iam/aws-policies.md)
* [`iam group-policies`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/iam/group-policies.md)
* [`iam group-policy`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/iam/group-policy.md)
* [`iam groups`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/iam/groups.md)
* [`iam instance-profiles`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/iam/instance-profiles.md)
* [`iam keys`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/iam/keys.md)
* [`iam keys-last-used`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/iam/keys-last-used.md)
* [`iam mfa`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/iam/mfa.md)
* [`iam password-policy`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/iam/password-policy.md)
* [`iam policies`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/iam/policies.md)
* [`iam policy-version`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/iam/policy-version.md)
* [`iam role`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/iam/role.md)
* [`iam role-policies`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/iam/role-policies.md)
* [`iam role-policy`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/iam/role-policy.md)
* [`iam roles`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/iam/roles.md)
* [`iam saml-provider`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/iam/saml-provider.md)
* [`iam saml-providers`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/iam/saml-providers.md)
* [`iam user`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/iam/user.md)
* [`iam user-policies`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/iam/user-policies.md)
* [`iam user-policy`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/iam/user-policy.md)
* [`iam users`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/iam/users.md)
* [`kms`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/kms/index.md)
* [`kms aliases`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/kms/aliases.md)
* [`kms policies`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/kms/policies.md)
* [`kms policy`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/kms/policy.md)
* [`lambda`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/lambda/index.md)
* [`lambda code`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/lambda/code.md)
* [`lambda function`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/lambda/function.md)
* [`lambda versions`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/lambda/versions.md)
* [`logs`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/logs/index.md)
* [`logs export-tasks`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/logs/export-tasks.md)
* [`logs groups`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/logs/groups.md)
* [`logs streams`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/logs/streams.md)
* [`me`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/me/index.md)
* [`orgs`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/orgs/index.md)
* [`rds`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/rds/index.md)
* [`rds cluster`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/rds/cluster.md)
* [`rds clusters`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/rds/clusters.md)
* [`rds engine-versions`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/rds/engine-versions.md)
* [`rds events`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/rds/events.md)
* [`rds instance`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/rds/instance.md)
* [`route53`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/route53/index.md)
* [`route53 records`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/route53/records.md)
* [`s3`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/s3/index.md)
* [`s3 acl`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/s3/acl.md)
* [`s3 encryption`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/s3/encryption.md)
* [`s3 lifecycle`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/s3/lifecycle.md)
* [`s3 location`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/s3/location.md)
* [`s3 notifications`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/s3/notifications.md)
* [`s3 objects`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/s3/objects.md)
* [`s3 policy`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/s3/policy.md)
* [`s3 website`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/s3/website.md)
* [`secretsmanager`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/secretsmanager/index.md)
* [`secretsmanager policy`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/secretsmanager/policy.md)
* [`secretsmanager secret`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/secretsmanager/secret.md)
* [`secretsmanager value`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/secretsmanager/value.md)
* [`ses`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/ses/index.md)
* [`sns`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/sns/index.md)
* [`sns subscriptions`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/sns/subscriptions.md)
* [`sqs`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/sqs/index.md)
* [`ssm`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/ssm/index.md)
* [`ssm instance-associations`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/ssm/instance-associations.md)
* [`ssm parameter`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/ssm/parameter.md)
* [`ssm parameters`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/ssm/parameters.md)
* [`ssm session`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/ssm/session.md)
* [`version`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/version/index.md)
* [`vpc`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/vpc/index.md)
* [`vpc endpoint`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/vpc/endpoint.md)
* [`vpc endpoints`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/vpc/endpoints.md)
* [`vpc endpoints-available`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/vpc/endpoints-available.md)
* [`vpc nat-gateways`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/vpc/nat-gateways.md)
* [`vpc network-acl`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/vpc/network-acl.md)
* [`vpc network-acls`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/vpc/network-acls.md)
* [`vpc network-interface`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/vpc/network-interface.md)
* [`vpc network-interfaces`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/vpc/network-interfaces.md)
* [`vpc peering-connections`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/vpc/peering-connections.md)
* [`vpc route-table`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/vpc/route-table.md)
* [`vpc route-tables`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/vpc/route-tables.md)
* [`vpc security-group`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/vpc/security-group.md)
* [`vpc security-groups`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/vpc/security-groups.md)
* [`vpc subnet`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/vpc/subnet.md)
* [`vpc subnets`](https://github.com/theserverlessway/awsinfo/blob/master/scripts/commands/vpc/subnets.md)