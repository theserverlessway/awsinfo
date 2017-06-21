# `awsinfo acm [substrings]*`

List all ACM certificates, with their `Domain` and `Arn`.
If `substrings` are given it will only print certificates where the `Domain` contains all `substrings`.

## Examples:

* ```awsinfo acm .io``` for all `.io` Domains.
* ```awsinfo acm example.com``` for the example.com domain (and all its subdomain certificates)
