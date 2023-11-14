awscli codebuild list-report-groups --output table --query "reportGroups[$(auto_filter_joined @ -- "$@")]"
