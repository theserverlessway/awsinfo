awscli iam list-policies --scope AWS --output table --query "Policies[$(auto_filter_joined PolicyName -- "$@")].{\"1.Name\":PolicyName,\"2.Id\":PolicyId,\"3.AttachedTo\":AttachmentCount\"4.Arn\":Arn}"