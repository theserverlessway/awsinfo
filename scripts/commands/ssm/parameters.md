# `awsinfo ssm [parameter-filter]*`

List all SSM Parameters.

## Options

* `-f`: Will only load Parameters containing the filter. With large number of parameters this is necessary to not have requests throttled.

## Filter matches against

* Name
* LastModifiedUser
* Type