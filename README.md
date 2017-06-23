# AWSINFO

```bash
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│                 ___   ____    __    ____   _______. __  .__   __.  _______   ______              │
│                /   \  \   \  /  \  /   /  /       ||  | |  \ |  | |   ____| /  __  \             │
│               /  ^  \  \   \/    \/   /  |   (----`|  | |   \|  | |  |__   |  |  |  |            │
│              /  /_\  \  \            /    \   \    |  | |  . `  | |   __|  |  |  |  |            │
│             /  _____  \  \    /\    / .----)   |   |  | |  |\   | |  |     |  `--'  |            │
│            /__/     \__\  \__/  \__/  |_______/    |__| |__| \__| |__|      \______/             │
│                                                                                                  │
└──────────────────────────────────────────────────────────────────────────────────────────────────┘
```

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
docker run -it -v ~/.aws:/root/.aws -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN -e AWS_DEFAULT_REGION -e AWS_DEFAULT_PROFILE -e AWS_CONFIG_FILE flomotlik/awsinfo ARGUMENTS_FOR_AWSINFO
```

You can set it up as an alias in your shell config file as well.

```bash
alias awsinfo=docker run -it -v ~/.aws:/root/.aws -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN -e AWS_DEFAULT_REGION -e AWS_DEFAULT_PROFILE -e AWS_CONFIG_FILE flomotlik/awsinfo
```

### Whalebrew

If you're using [Whalebrew](https://github.com/bfirsh/whalebrew)(Which I highly recommend you doing) simply run the following to install:
 
 ```bash
whalebrew install flomotlik/awsinfo
```

## Update

To update the Docker container run `docker pull flomotlik/awsinfo:latest`

## Usage

`awsinfo` commands support commands and subcommands, for example you can run `awsinfo logs` to print log messages
or `awsinfo logs groups` to get a list of all log groups in the current account and region.

To see all available commands check out the following list or run `awsinfo commands`.

You can run any command with `--help` (e.g. `awsinfo logs --help`) to see the same help 
page that is in the repo (and linked below).

## Available Commands

* [`acm `](scripts/commands/acm/index.md)
* [`cfn `](scripts/commands/cfn/index.md)
* [`cfn change-sets`](scripts/commands/cfn/change-sets.md)
* [`cfn events`](scripts/commands/cfn/events.md)
* [`cfn exports`](scripts/commands/cfn/exports.md)
* [`cfn imports`](scripts/commands/cfn/imports.md)
* [`cfn outputs`](scripts/commands/cfn/outputs.md)
* [`cfn policy`](scripts/commands/cfn/policy.md)
* [`cfn resources`](scripts/commands/cfn/resources.md)
* [`cloudwatch alarms`](scripts/commands/cloudwatch/alarms.md)
* [`commands `](scripts/commands/commands/index.md)
* [`dynamodb `](scripts/commands/dynamodb/index.md)
* [`dynamodb table`](scripts/commands/dynamodb/table.md)
* [`ec2 `](scripts/commands/ec2/index.md)
* [`ec2 keys`](scripts/commands/ec2/keys.md)
* [`ec2 sg`](scripts/commands/ec2/sg.md)
* [`ecs `](scripts/commands/ecs/index.md)
* [`elb `](scripts/commands/elb/index.md)
* [`iam groups`](scripts/commands/iam/groups.md)
* [`iam instance-profiles`](scripts/commands/iam/instance-profiles.md)
* [`iam policies`](scripts/commands/iam/policies.md)
* [`iam roles`](scripts/commands/iam/roles.md)
* [`iam user`](scripts/commands/iam/user.md)
* [`iam users`](scripts/commands/iam/users.md)
* [`logs `](scripts/commands/logs/index.md)
* [`logs groups`](scripts/commands/logs/groups.md)
* [`me `](scripts/commands/me/index.md)
* [`orgs `](scripts/commands/orgs/index.md)
* [`route53 `](scripts/commands/route53/index.md)
* [`route53 records`](scripts/commands/route53/records.md)
* [`sns `](scripts/commands/sns/index.md)
* [`sns subscriptions`](scripts/commands/sns/subscriptions.md)
* [`sqs `](scripts/commands/sqs/index.md)
* [`sts assume`](scripts/commands/sts/assume.md)