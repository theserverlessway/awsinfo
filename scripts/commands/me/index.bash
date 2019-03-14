CALLER_IDENTITY=$(awscli sts get-caller-identity --output json --query "{\"1.AccountId\":Account,\"3.Arn\":Arn,\"4.UserId\":UserId}")

ALIAS=$(awscli iam list-account-aliases --output json --query "{\"2.AccountAlias\":AccountAliases[0]||''}")

echo -e "$CALLER_IDENTITY\n$ALIAS" | print_table AccountDetails