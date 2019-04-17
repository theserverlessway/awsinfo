# `awsinfo iam group-policy [group-filters]+ -- [policy-filters]*`

Show the details of the specified policy for a group. Filters before `--` are used to select the group, filters after `--` are used to select the policy. Policy filters are optional as it will choose the first one if none are given.

## First Filter matches against

* Group Name
* Group Id
* Path

## Second Filter matches against

* Policy Name