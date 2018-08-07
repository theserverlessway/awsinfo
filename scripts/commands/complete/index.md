# `awsinfo complete`

Returns a bash autocomplete script you can include in your bash startup.

You can either run it directly as part of your bash init by adding the following command to your
completion file, bash_profile or similar. As `awsinfo` is running inside Docker you have
to add the `tr` command at the end to make sure it removes the `\r` from the output.

```
eval "$(awsinfo complete | tr -d '\r')"
```

Another option is to regularly export the command and add it to your bash startup scripts.
Of course if new commands are added they won't be available in autocomplete right away so
you have to rerun the command

```
awsinfo complete | tr -d '\r' > awsinfo_completion.bash
```
