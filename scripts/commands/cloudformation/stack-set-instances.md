# `awsinfo cloudformation stack-set-instances [-a ACCOUNT_ID] [-r REGION] [stack-set-filter]* -- [instances-filters]*`

Describe Instances for a CloudFormation StackSet.
If you have more than 100 StackSet Instances use `-a`
or `-r` to limit the returned StackSets from the API to specific
accounts or regions. Otherwise you will not see all instances.

You can of course still use the below filters together with `-r`
and `-a` as the filter work against the returned data.

## First Filter matches against

* StackSet Name

## Second Filter matches against

* Account
* Region
* StackId
* Status
