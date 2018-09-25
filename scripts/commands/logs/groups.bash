awscli logs describe-log-groups --query "logGroups[$(auto_filter logGroupName -- $@)].[logGroupName]" --output table
