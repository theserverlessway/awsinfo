# `awsinfo assume [organisation-filters]+ -- [RoleName]`

`awsinfo assume` will assume the `ROLE_NAME` (or OrganizationAccountAccessRole by default)
for the filtered organisation account and print Environment Variables you can directly export
into your environment so you can work as the assumed role.

## Organisations Filter matches against

* Name
* Id
* Status
* Email

## Example

Following is an example that prints the variables on the cli. You can then copy them by hand or eval them directly:
You can use `awsinfo me` to see which account you're using.

Lets say you have the following accounts:
```
awsinfo orgs
-----------------------------------------------------------------------------------------------
|                                        ListAccounts                                         |
+------------------+---------------+-----------+----------------------------------------------+
|      1.Name      |     2.Id      | 3.Status  |                   4.Email                    |
+------------------+---------------+-----------+----------------------------------------------+
|  tslw-development|  123456789876 |  ACTIVE   |  development@theserverlessway.com            |
|  tslw-production |  987654321234 |  ACTIVE   |  production@theserverlessway.com             |
+------------------+---------------+-----------+----------------------------------------------+
```

We can then tell awsinfo we want to assume into the dev account. Filtering works the same for assume as it does
for other commands. If we don't add a role it will use the default role

```
awsinfo me
awsinfo assume dev

export AWS_ACCESS_KEY_ID=REDACTED_KEY AWS_SECRET_ACCESS_KEY=REDACTED_SECRET AWS_SESSION_TOKEN="REDACTED_TOKEN"
# COPY AND RUN EXPORTS NOW!

awsinfo me
```

If you want to set a specific Role you can do that as well of course

```
awsinfo assume dev -- SomeOtherRoleName
```

When you eval the output directly and run `awsinfo` in a Docker container you might run into problems with line
endings as Docker run with a TTY will add a carriage-return at the end of a line. the `tr -d '\r'` call will fix
this.

```
awsinfo me
eval $(awsinfo sts assume 12345678987654321 OrganizationAccountAccessRole --profile default | tr -d '\r')
export AWS_ACCESS_KEY_ID=REDACTED_KEY AWS_SECRET_ACCESS_KEY=REDACTED_SECRET AWS_SESSION_TOKEN="REDACTED_TOKEN"
awsinfo me
```