FILTER=$(auto_filter_joined InternetGatewayId "join('',Attachments[].VpcId)" "join('',Tags[].Value)" -- "$@")

awscli ec2 describe-internet-gateways --output table --query "InternetGateways[$FILTER].{
  \"1.InternetGatewayId\":InternetGatewayId,
  \"2.Attachments\":join(',', Attachments[].VpcId),
  \"3.OwnerId\": OwnerId}"
