awscli backup list-backup-jobs --output table --query "sort_by(BackupJobs,&CreationDate)[$(auto_filter BackupJobId BackupVaultName ResourceArn State ResourceType -- $@)].{
  \"1.Id\":BackupJobId,
  \"2.BackupVaultName\":BackupVaultName,
  \"3.CompletedAt\":CompletionDate,
  \"3.State\": State,
  \"4.ResourceArn\":ResourceArn}"
