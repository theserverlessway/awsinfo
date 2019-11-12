FROM amazonlinux:latest
RUN yum install -y groff less mailcap jq make bash coreutils python3

ADD https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm session-manager-plugin.rpm
RUN yum install -y session-manager-plugin.rpm
RUN rm session-manager-plugin.rpm
RUN yum clean all

RUN pip3 install awscli

COPY scripts /awsinfo/scripts

RUN ln -s /awsinfo/scripts/awsinfo.bash /usr/local/bin/awsinfo

ENTRYPOINT ["awsinfo"]

LABEL io.whalebrew.config.environment '["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY", "AWS_SESSION_TOKEN", "AWS_DEFAULT_REGION", "AWS_PROFILE", "AWS_DEFAULT_PROFILE", "AWS_CONFIG_FILE", "AWSINFO_DEBUG"]'
LABEL io.whalebrew.config.volumes '["~/.aws:/.aws"]'

ARG AWSINFO_VERSION
ENV AWSINFO_VERSION $AWSINFO_VERSION
