# `awsinfo elb old [substrings]*`

Lists all Elastic Load Balancers.

If `substrings`is given it will only print Load Balancers that contain all `substrings` in the `LoadBalancerName`,
`VPCId`, `Subnets`, `AvailabilityZones` or `InstanceId` giving you a very simple way to view only the ELBs with
the specific characteristics you're interseted in.