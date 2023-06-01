FILTER=$(auto_filter_joined RouteTableId "$TAG_NAME" VpcId -- "$@")
ROUTE_TABLES_LISTING=$(awscli ec2 describe-route-tables --output text --query "RouteTables[$FILTER].[RouteTableId]")

select_one RouteTable "$ROUTE_TABLES_LISTING"

awscli ec2 describe-route-tables --output table --route-table-ids "$SELECTED" --query "RouteTables[0]"