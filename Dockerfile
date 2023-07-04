FROM python:latest
RUN apt-get update
RUN apt-get install -y groff less jq make bash coreutils python3 curl shellcheck

RUN wget https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_$(if [ $(dpkg --print-architecture) = "amd64" ] ; then echo "64bit" ; else echo "arm64" ; fi)/session-manager-plugin.deb
RUN dpkg -i session-manager-plugin.deb
RUN rm session-manager-plugin.deb

RUN pip3 install awscli

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

COPY scripts /awsinfo/scripts

RUN ln -s /awsinfo/scripts/awsinfo.bash /usr/local/bin/awsinfo

ENTRYPOINT ["awsinfo"]

LABEL io.whalebrew.config.environment '["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY", "AWS_SESSION_TOKEN", "AWS_DEFAULT_REGION", "AWS_PROFILE", "AWS_DEFAULT_PROFILE", "AWS_CONFIG_FILE", "AWSINFO_DEBUG"]'
LABEL io.whalebrew.config.volumes '["~/.aws:/.aws"]'
