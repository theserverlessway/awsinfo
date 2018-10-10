FILTER=$(auto_filter "User.UserName||''" "User.UserId||''" "User.Path||''" -- $@)

awscli iam list-virtual-mfa-devices --output table --query "VirtualMFADevices[$FILTER].{
\"1.SerialNumber\":SerialNumber,
\"2.UserName\":User.UserName,
\"3.UserId\":User.UserId,
\"4.UserPath\":User.Path}"
