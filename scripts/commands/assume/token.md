# `awsinfo assume token [-d DurationInHours] [-s MFA_SERIAL_NUMBER] [-t MFA_TOKEN] [-m MFA_TOKEN]`

Get Session Tokens that can optionally be authorized with MFA.

If you specify `-m` but no MFA Serial Number with `-s` it will build that arn out of the current account id and your username.