FROM python:alpine

RUN apk --no-cache add bash coreutils jq make
RUN pip install awscli

COPY scripts /awsinfo/scripts

RUN ln -s /awsinfo/scripts/awsinfo.bash /usr/local/bin/awsinfo

ENTRYPOINT ["awsinfo"]

LABEL io.whalebrew.config.environment '["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY", "AWS_SESSION_TOKEN", "AWS_DEFAULT_REGION", "AWS_PROFILE", "AWS_DEFAULT_PROFILE", "AWS_CONFIG_FILE", "AWSINFO_DEBUG"]'
LABEL io.whalebrew.config.volumes '["~/.aws:/.aws"]'

ARG AWSINFO_VERSION
ENV AWSINFO_VERSION $AWSINFO_VERSION
