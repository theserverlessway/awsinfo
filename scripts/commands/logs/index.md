# `awslogs logs [options] [log-group-filters]* -- [log-stream-filters]*`

Print log statements from a log group. The `log-group=filters` will be used to identify the LogGroup to load from, the `log-stream-filters` will be used to limit to specific LogStreams. Text Fragments that uniquely identify a LogGroup and LogStream are enough, e.g. Instead of having to write `/aws/codebuild/msearch-indexer-bulk-build`
as the full log group name you can use `codebuild index bulk` to uniquely identify the group.
If multiple log groups match it will print the matching groups and select the first.

It will use `filter-log-events` from the `awscli` to regularly get new log events and print any events that
haven't been seen before.

By default the command will watch regularly for new messages and print them to the console.
This can be stopped with ctrl-c.

This command is heavily inspired by the great [awslogs](https://github.com/jorgebastida/awslogs)
tool by [jorgebastida](https://github.com/jorgebastida). The main difference compared to awslogs (apart from being
written in bash and not python) is that it supports new log-streams coming in while logs are being watched and
some UX improvements like matching log-groups with substrings.

## Options:

* `-G`: Remove the log group name from the output
* `-S`: Add the stream name to the log output
* `-p`: Set a log stream prefix so only log stream with that prefix are read from
* `-f`: Filter log events you want to see.
        See [Filter Patter Syntax](http://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html)
* `-s`: Start time to search from. Uses [Gnu Date](https://www.gnu.org/software/coreutils/manual/html_node/Options-for-date.html#Options-for-date) which supports a complex date syntax. Automatically converts to UTC.
        (e.g. "now", "-5minutes", "-3days", "Monday", "15:30", "2017-01-01T06:30"). The current implementation doesn't allow for whitespace in the dates.
* `-e`: End time to search to. Same syntax as start time before. Will disable log watching (implicit -w argument)
* `-t`: Print timestamp for log message
* `-i`: Print ingestion time for log message
* `-w`: Do not watch the log and end after getting the first set of log messages
