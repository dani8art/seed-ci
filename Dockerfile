FROM docker.io/bitnami/minideb:buster

ARG JQ_VERSION=1.6
ARG YQ_VERSION=3.4.1
ARG CT_VERSION=3.7.1
ARG HELM_VERSION=3.10.2
ARG PYTHON_VERSION=3.10.8-2

USER root

RUN install_packages acl ca-certificates curl wget gzip libc6 libcom-err2 libcurl4 libffi6 libgcrypt20 libgmp10 \
  libgnutls30 libgpg-error0 libgssapi-krb5-2 libhogweed4 libidn2-0 libk5crypto3 libkeyutils1 libkrb5-3 \
  libkrb5support0 libldap-2.4-2 libnettle6 libnghttp2-14 libp11-kit0 libpsl5 librtmp1 libsasl2-2 libssh2-1 \
  libssl1.1 libtasn1-6 libunistring2 procps ssh sudo tar zlib1g git yamllint

RUN curl -Lso /usr/local/bin/jq "https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64" && \
  chmod +x /usr/local/bin/jq
RUN curl -Lso /usr/local/bin/yq "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64" && \
  chmod +x /usr/local/bin/yq

ARG CT_TAR_FILENAME="chart-testing_${CT_VERSION}_linux_amd64.tar.gz"
RUN mkdir -p /tmp/ct-files/ && \
  curl -Lso "/tmp/ct-files/${CT_TAR_FILENAME}" "https://github.com/helm/chart-testing/releases/download/v${CT_VERSION}/${CT_TAR_FILENAME}" && \
  tar -xzf "/tmp/ct-files/${CT_TAR_FILENAME}" -C /tmp/ct-files/ && \
  cp /tmp/ct-files/ct /usr/local/bin && \
  rm -rf /tmp/ct-files
COPY ct /etc/ct

RUN wget -nc -P /tmp/bitnami/pkg/cache/ https://downloads.bitnami.com/files/stacksmith/python-${PYTHON_VERSION}-linux-amd64-debian-10.tar.gz && \
  tar -zxf /tmp/bitnami/pkg/cache/python-${PYTHON_VERSION}-linux-amd64-debian-10.tar.gz -P --transform 's|^[^/]*/files|/opt/bitnami|' --wildcards '*/files' && \
  rm -rf /tmp/bitnami/pkg/cache/python-${PYTHON_VERSION}-linux-amd64-debian-10.tar.gz

ENV PATH="/opt/bitnami/python/bin:$PATH"

RUN pip install yamale

ARG HELM_TAR_FILENAME="helm-v${HELM_VERSION}-linux-amd64.tar.gz"
RUN mkdir -p /tmp/helm-files/ && \
  curl -Lso "/tmp/helm-files/${HELM_TAR_FILENAME}" "https://get.helm.sh/${HELM_TAR_FILENAME}" && \
  tar -xzf "/tmp/helm-files/${HELM_TAR_FILENAME}" -C /tmp/helm-files/ && \
  cp /tmp/helm-files/linux-amd64/helm /usr/local/bin && \
  rm -rf /tmp/helm-files
