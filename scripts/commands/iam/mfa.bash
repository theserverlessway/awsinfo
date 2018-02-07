awscli iam list-virtual-mfa-devices --output table --query "VirtualMFADevices[$(auto_filter User.UserName User.UserId User.Path -- $@)].User.{
\"1.Arn\":Arn,
\"2.UserName\":UserName,
\"3.UserId\":UserId,
\"4.Path\":Path,
\"5.PasswordLastUsed\":PasswordLastUsed,
\"6.CreateDate\":CreateDate}"
