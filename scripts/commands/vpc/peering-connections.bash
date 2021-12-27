awscli ec2 describe-vpc-peering-connections --output table --query "VpcPeeringConnections[$(auto_filter_joined AccepterVpcInfo.VpcId AccepterVpcInfo.CidrBlock RequesterVpcInfo.VpcId RequesterVpcInfo.CidrBlock VpcPeeringConnectionId Status.Message -- $@)].{
  \"1.Id\":VpcPeeringConnectionId,
  \"2.Status\":Status.Message,
  \"3.RequesterVPC\":RequesterVpcInfo.VpcId,
  \"4.RequesterCIDR\":RequesterVpcInfo.CidrBlock,
  \"5.AccepeterVPC\":AccepterVpcInfo.VpcId
  \"6.AccepeterCIDR\":AccepterVpcInfo.CidrBlock}"