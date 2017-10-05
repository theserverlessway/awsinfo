# `awsinfo cfn change-set [stack-filters]+ -- [change-set-filters]*`

Show the details of the specified ChangeSet for a stack. Filters before `--` are used to select the stack,
filters after `--` are used to select the ChangeSet. ChangeSet filters are optional as it will choose the
first one if none are given.

## First Filter matches against

* Stack Name

## Second Filter matches against

* ChangeSet Name