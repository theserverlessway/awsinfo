split_args "$@"

APPLICATIONS=$(awscli elasticbeanstalk describe-applications --output text --query "sort_by(Applications,&ApplicationName)[$(filter ApplicationName $FIRST_RESOURCE)].[ApplicationName]")
select_one Application "$APPLICATIONS"

awscli elasticbeanstalk describe-application-versions --application-name "$SELECTED" --output table --query "ApplicationVersions[$(filter VersionLabel $SECOND_RESOURCE)].{\"1.ApplicationName\":ApplicationName,\"2.VersionLabel\":VersionLabel,\"3.Status\":Status,\"4.DateCreated\":DateCreated, \"5.Source\":join('/', ['s3:/',SourceBundle.S3Bucket,SourceBundle.S3Key])}"
