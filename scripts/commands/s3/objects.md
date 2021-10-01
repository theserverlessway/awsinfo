# `awsinfo s3 objects [first-filters]+ -- [second-filters]*`

List objects in a Bucket. For large buckets use the `-p` option
to limit by prefixes or `-m` to reduce the number of results.

## Options

* `-l`: Sorty by LastModified
* `-m`: Max Items to show
* `-p`: Prefix to filter with

## First Filter matches against

* Bucket Name

## Second Filter matches against

* Object Key