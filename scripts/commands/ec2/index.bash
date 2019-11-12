EC2_FILTER="--filter Name=instance-state-name,Values=pending,running"

while getopts "t" opt; do
    case "$opt" in
        t) EC2_FILTER="";;
    esac
done
shift $(($OPTIND-1))

SECURITY_GROUPS="NetworkInterfaces|length(@)"
FILTER=$(auto_filter "$TAG_NAME" InstanceId InstanceType State.Name Placement.AvailabilityZone "$SECURITY_GROUPS" -- $@)

awscli ec2 describe-instances --output table $EC2_FILTER --query "sort_by(Reservations,&Instances[0].LaunchTime)[].Instances[$FILTER][].{\"1.Name\":$TAG_NAME,\"2.InstanceId\":InstanceId,\"3.Type\":InstanceType,\"4.State\":State.Name,\"5.NetworkInterfaces\":$SECURITY_GROUPS,\"6.LaunchTime\":LaunchTime,\"7.AZ\":Placement.AvailabilityZone,\"8.PublicDNS\":PublicDnsName, \"9.PrivateDNS\":PrivateDnsName}"