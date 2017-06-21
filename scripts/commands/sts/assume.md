# `awsinfo sts assume ACCOUNT_ID ROLE_NAME`

`awsinfo sts assume` will assume the `ROLE_NAME` for the `ACCOUNT_ID` given and print Environment Variables
 you can directly export into your environment so you can work as the assumed role.

Following is an example that prints the variables on the cli. You can then copy them by hand or eval them directly:
You can use `awsinfo me` to see which account you're using.

```bash
awsinfo me
awsinfo sts assume 12345678987654321 OrganizationAccountAccessRole --profile default
export AWS_ACCESS_KEY_ID=REDACTED_KEY AWS_SECRET_ACCESS_KEY=REDACTED_SECRET AWS_SESSION_TOKEN="REDACTED_TOKEN"
# COPY AND RUN EXPORTS NOW! 
awsinfo me
```

When you eval the output directly and run `Awsinfo` in a Docker container you might run into problems with line
endings as Docker run with a TTY will add a carriage-return at the end of a line. the `tr -d '\r'` call will fix
this until its fixed in the AWSCLI.

```bash
awsinfo me
eval $(awsinfo sts assume 12345678987654321 OrganizationAccountAccessRole --profile default | tr -d '\r')
export AWS_ACCESS_KEY_ID=REDACTED_KEY AWS_SECRET_ACCESS_KEY=REDACTED_SECRET AWS_SESSION_TOKEN="REDACTED_TOKEN"
awsinfo me
```