# Contributing to AWSInfo

Contributing commands to AWSInfo is a relatively quick process. If you're using Docker on your system you can start a Docker development container with `make shell` to drop into a consistent environment to develop the new AWSInfo command.

As there are already a lot of commands implemented looking into one of the existing ones (on top of the examples used when creating a new resource) should give you good insights into developing new AWSInfo commands.

## Create command

AWSInfo comes with a `make create` command that will ask you which service to create a command for and what the command name is supposed to be. It will copy an example to the command location that you can use to implement the specific command. 

All the following examples are part of the [`example command`](scripts/command_example/command.bash) so take a look at the file for a working example.

There are typically 3 kinds of commands

1. Listing of Resources with some Filters, e.g. CloudFormation list-stacks
2. Listing a sub-resource, e.g. all Resources in a CloudFormation Stack. There you need to first select the main resources (the cloudformation Stack in this case) and then select the resources to show. This will also involve two levels of filtering.
3. Showing a specific resource with all its configuration, e.g. a VPC Subnet. This can potentially also involve a two step process where you have to select the main resource first, then the sub-resource that you want to show in full.

## AWSInfo and the AWS CLI

AWSInfo is built on top of the AWS CLI to make it easy to take commands used in AWSInfo and adjust them to your needs. This also means we're using various options like [`--query`](https://theserverlessway.com/aws/cli/query/) and [`--output`](https://theserverlessway.com/aws/cli/output/) extensively in the scripts. For more details on both check the linked guides.

 The `--query` option is especially important when we want to select which data to show for a specific command.
 
 ## Filtering and Filter Inputs
 
 Filtering is one of the core features of AWSInfo to find the resources you want to see quickly. For more details on how to use Filtering check out the [Documentation](https://theserverlessway.com/tools/awsinfo/filters/).
 
 Implementing Filtering is also pretty easy. There are two main features to think about when using filters:
 
 1. Splitting filter arguments for multi level filtering
 2. Using the `auto_filter` function to create JMESPATH filters
 
 ### Filter Argument Splitting
 
 AWSInfo supports two levels of filtering, for example if you want to select all Resources in a CloudFormation Stack  named `production` that have Lambda in their name or as a type for the you would use something like `awsinfo cloudformation resources prod -- Lambda`. 
 
 Using `prod` here shows the power of filtering as its a substring matching, so if the filter string is part of the name (or other specified attributes of a resource) it will select all matching resources. In this specific case it would also only select the first one found in the sorted match list to then get the resources of the Stack. For those resources again only those that have Lambda in their name or type would be shown. in this case we only used one filter per resource, but we can use more, e.g. `awsinfo cloudformation resources pr od -- Lam bda` should match the same resources. There is no limit on how many filter terms you can have.
 
 To make it easy in the script to differentiate between both filter arguments we have the `split_args` function. It will take all arguments and split them with everything before `--` going into a `$FIRST_RESOURCE` environment variable. All terms following `--` will be put into the `$SECOND_RESOURCE` environment variable.
 
 Those variables can then be used for auto filtering resources.
 
 ### Auto Filter
 
 For filtering to work we need to decide with resource arguments are used for filtering a certain resource and then create a filter string we can hand to the `--query` option of the awscli. The `auto_filter` option makes this easy as it takes a number of names and builds a filter for us. `auto_filter` takes the resource attributes and then the filter terms separated by `--`. To test it yourself you can run the following:
 
 ```shell script
bash-4.4# source scripts/helpers/filters.bash scripts/helpers/functions.bash # Source the files containing the shell functions
bash-4.4# auto_filter StackName -- prod
?contains(StackName,'prod')
``` 

The `contains` filter does a string matching in JMESPATH. The following example shows how the auto_filter is used in an awscli command. Here the filter terms are simply all arguments handed to awsinfo.  
 
```shell script
awscli cloudformation describe-stacks --output table --query "sort_by(Stacks,&StackName)[$(auto_filter StackName -- $@)]"
```

The following example creates a list of CloudFormation StackNames filtered by StackName but only with `$FIRST_RESOURCE` for commands that have two filter sets. 

 ```shell script
STACK_LISTING=$(awscli cloudformation describe-stacks --output text --query "sort_by(Stacks,&StackName)[$(auto_filter StackName -- $FIRST_RESOURCE)].[StackName]")
```

As `contains` does string matching you sometimes have to convert a value to string (otherwise the command will fail).
To do this set the output from auto_filter to a variable and use the `to_string` method in JMESPath. Anytime you use a method of JMESPath it's better to put the filter into a variable first so you can put Apostrophes around the method call. We can then use the `FILTER` shell variable as in the following example:

```shell script
FILTER=$(auto_filter VpcId "$TAG_NAME" "to_string(IsDefault)" -- $@)
awscli ec2 describe-vpcs --output table --query "Vpcs[$FILTER]
```

Sometimes you might also want to join different attributes together into a string before string matching, e.g. For a Cloudfront Distribution you might want to join all aliases into one string so they can be searched. Because its substring matching it isn't a problem when they are joined, you will still find them.

In the [cloudfront command](scripts/commands/cloudfront/index.bash) we're using the `join` JMESPath method to combine `Aliases.Items`, but also define an empty array in case no Aliases exist with `||[''']`. Without that default Array the command would fail as `Aliases.Items` could be non-existent.

```shell script
FILTER=$(auto_filter Id DomainName Status "join(',',Aliases.Items||[''])" -- $@)
```

For more information and input check out other commands implemented to see how different issues are done. If something is unclear please open an issue so it can be addressed in the documentation as well.

## Documentation

Every command needs to come with a Markdown file with the same name and documentation for it. Otherwise the build will fail (and PR review won't go trough either). If you use the `make create` command a markdown file will be created for you. Update it with the details necessary for your command.