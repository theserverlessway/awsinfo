SUBNETS="join(',',Associations[].SubnetId)"

FILTER=$(auto_filter VpcId NetworkAclId $SUBNETS $TAG_NAME -- $@)

NETWORK_ACLS=$(awscli ec2 describe-network-acls --output text --query "NetworkAcls[$FILTER].[NetworkAclId]")
select_one NetworkACL "$NETWORK_ACLS"

awscli ec2 describe-network-acls --output table --filters "Name=network-acl-id,Values=$SELECTED"
