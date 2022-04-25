BACKUP_VAULTS=$(awscli backup list-backup-vaults --output text --query "sort_by(BackupVaultList,&BackupVaultName)[$(auto_filter BackupVaultName -- $@)].[BackupVaultName]")
select_one Stack "$BACKUP_VAULTS"

awscli backup describe-backup-vault --backup-vault-name $SELECTED --output table