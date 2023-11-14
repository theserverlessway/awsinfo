FILTER=$(auto_filter_joined InternetGatewayId "join('',Attachments[].VpcId)" "join('',Tags[].Value)" -- "$@")

INTERNET_GATEWAYS=$(awscli ec2 describe-internet-gateways --output text --query "InternetGateways[$FILTER].[InternetGatewayId]")
select_one InternetGateway "$INTERNET_GATEWAYS"

awscli ec2 describe-internet-gateways --filter "Name=internet-gateway-id,Values=$SELECTED" --output table