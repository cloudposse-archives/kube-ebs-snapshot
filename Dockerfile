FROM alpine:3.4

ARG K8S_VERSION=v1.5.6

ENV DESCRIPTION=
ENV EXTERNAL_ARGS=
ENV TAGS=

RUN apk update \
    && apk add unzip \
          python make bash jq


ADD https://storage.googleapis.com/kubernetes-release/release/$K8S_VERSION/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl

# Install aws cli bundle
ADD https://s3.amazonaws.com/aws-cli/awscli-bundle.zip ./awscli-bundle.zip
RUN unzip awscli-bundle.zip \
    && ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws \
    && rm awscli-bundle.zip \
    && rm -rf awscli-bundle

ADD rootfs /

ENTRYPOINT /bin/create-snapshot