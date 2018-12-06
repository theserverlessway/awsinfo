# `awsinfo assume role -r ROLE_NAME [-a ACCOUNT_ID] [-d DurationInHours] [-s MFA_SERIAL_NUMBER] [-t MFA_TOKEN]`

Assume a specific Role with optional MFA device support. When you don't have access to list the Organisations this allows
you to specify the Account ID directly. If you don't specify the Account Id the command will send a request to
AWS to determine the account id of the credentials currently used and use that ID.
