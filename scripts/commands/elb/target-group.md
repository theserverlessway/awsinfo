# `awsinfo elb target-group [load-balancer-filter]* -- [target-group-filter]*`

Describe a single TargetGroup with all its details

## First filter matches against

* LoadBalancerName
* VpcId
* Scheme
* Availability Zones
* SubnetIds
* Security Groups

## Second filter matches against

* TargetGroupName
* Port
* Protocol
