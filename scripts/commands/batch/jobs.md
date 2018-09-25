# `awsinfo batch jobs [job-queue-filter]* -- [job-filter]*`

List all running jobs

## Options

* `-p`: List all PENDING jobs
* `-p`: List all RUNNABLE jobs
* `-s`: List all SUCCEEDED jobs
* `-f`: List all FAILED jobs

## First filter matches against

* Name
* Status
* Compute Environment Name

## Second filter matches against

* Name
* Id
* Status
* Status Reason
