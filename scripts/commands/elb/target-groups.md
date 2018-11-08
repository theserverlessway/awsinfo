# `awsinfo elb target-groups [load-balancer-filter]* -- [target-group-filter]*`

List all Target Groups for a Load Balancer

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
