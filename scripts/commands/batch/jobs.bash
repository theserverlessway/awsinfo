JOBS_STATUS="RUNNING"

while getopts "prsf" opt; do
    case "$opt" in
        p) JOBS_STATUS="PENDING" ;;
        r) JOBS_STATUS="RUNNABLE" ;;
        s) JOBS_STATUS="SUCCEEDED" ;;
        f) JOBS_STATUS="FAILED" ;;
    esac
done
shift $(($OPTIND-1))

split_args "$@"

FILTER=$(auto_filter_joined jobQueueName status "join('',computeEnvironmentOrder[].computeEnvironment)" -- $FIRST_RESOURCE)

JOB_QUEUES=$(awscli batch describe-job-queues --output text --query "sort_by(jobQueues,&jobQueueName)[$FILTER].[jobQueueName]")
select_one JobQueue "$JOB_QUEUES"

awscli batch list-jobs --job-queue $SELECTED --output table --job-status "$JOBS_STATUS" \
  --query "jobSummaryList[$(auto_filter_joined jobName jobId  status statusReason -- $SECOND_RESOURCE)].{ \
    \"1.Id\":jobId, \
    \"2.Name\":jobName, \
    \"3.Status\":status, \
    \"4.StatusReason\":statusReason, \
    \"4.ExitCode\":container.exitCode}"
