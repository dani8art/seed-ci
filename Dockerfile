FROM docker.io/bitnami/minideb:buster

ARG JQ_VERSION=1.6
ARG YQ_VERSION=3.4.0

USER root

RUN install_packages acl ca-certificates curl gzip libc6 libcom-err2 libcurl4 libffi6 libgcrypt20 libgmp10 \
  libgnutls30 libgpg-error0 libgssapi-krb5-2 libhogweed4 libidn2-0 libk5crypto3 libkeyutils1 libkrb5-3 \
  libkrb5support0 libldap-2.4-2 libnettle6 libnghttp2-14 libp11-kit0 libpsl5 librtmp1 libsasl2-2 libssh2-1 \
  libssl1.1 libtasn1-6 libunistring2 procps ssh sudo tar zlib1g git

RUN curl -Lso /usr/local/bin/jq https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64 && \
  chmod +x /usr/local/bin/jq
RUN curl -Lso /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64 && \
  chmod +x /usr/local/bin/yq