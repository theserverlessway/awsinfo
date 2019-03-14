# `awsinfo assume role -r ROLE_NAME [-a ACCOUNT_ID] [-d DurationInHours] [-s MFA_SERIAL_NUMBER] [-t MFA_TOKEN] [-m WithMFA] `

Assume a specific Role with optional MFA device support. When you don't have access to list the Organisations this allows
you to specify the Account ID directly. If you don't specify the Account Id the command will send a request to
AWS to determine the account id of the credentials currently used and use that ID.

If you do not specificy a MFA token the command will ask for it.

If you specify `-m` but no MFA Serial Number with `-s` it will build that arn out of the current account id and your username.