# `awsinfo ec2 images [name-filter]`

Lists the EC2 images filtered by name and optionally owner.
The name filter parameter can contain wildcards. A wildcard is also automatically added to the beginning and the end of the provided name.

For example `awsinfo ec2 images -o amazon 'amzn2-ami-hvm*2021*86*ebs'` will look for all Amazon Linux 2 images from 2021 in `X86_64` infrastructure with `EBS` storage.

## Options

* `-o`: Owner of the images, e.g. `amazon` or your Account Id
