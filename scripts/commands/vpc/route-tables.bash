FILTER=$(auto_filter_joined RouteTableId "$TAG_NAME" VpcId -- $@)
awscli ec2 describe-route-tables --output table --query "RouteTables[$FILTER].{ \
  \"1.Name\":$TAG_NAME, \
  \"2.Id\": RouteTableId, \
  \"3.VpcId\": VpcId,
  \"4.SubnetAssociations\": Associations[].SubnetId||''|length(@)}"