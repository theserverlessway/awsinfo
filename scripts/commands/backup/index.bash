awscli backup list-backup-vaults --output table --query "sort_by(BackupVaultList,&BackupVaultName)[$(auto_filter BackupVaultName -- $@)].{
  \"1.Name\":BackupVaultName,
  \"2.NumberOfRecoveryPoints\":NumberOfRecoveryPoints,
  \"3.Locked\":Locked}"