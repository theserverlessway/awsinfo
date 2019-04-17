# `awsinfo iam user-policy [user-filters]+ -- [policy-filters]*`

Show the details of the specified policy for a user. Filters before `--` are used to select the user, filters after `--` are used to select the policy. Policy filters are optional as it will choose the first one if none are given.

## First Filter matches against

* User Name
* User Id
* Path

## Second Filter matches against

* Policy Name