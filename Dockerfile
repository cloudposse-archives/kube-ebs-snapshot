FROM alpine:3.4

ARG K8S_VERSION=v1.5.6

RUN apk update \
    && apk add unzip \
          python make bash \
          bash-completion && \
          mkdir /etc/bash_completion.d/


ADD https://storage.googleapis.com/kubernetes-release/release/$K8S_VERSION/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl

# Install aws cli bundle
ADD https://s3.amazonaws.com/aws-cli/awscli-bundle.zip ./awscli-bundle.zip
RUN unzip awscli-bundle.zip \
    && ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws \
    && rm awscli-bundle.zip \
    && rm -rf awscli-bundle \
    && ln -s /usr/local/aws/bin/aws_bash_completer /etc/bash_completion.d/aws.sh \
    && ln -s /us-r/local/aws/bin/aws_completer /usr/local/bin/

ADD rootfs /

ENTRYPOINT /bin/create-snapshot