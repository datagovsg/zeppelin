FROM openjdk:8-jre-alpine

ARG ZEPPELIN_VERSION=0.8.1
ENV ZEPPELIN_VERSION "${ZEPPELIN_VERSION}"

ARG OTHER_INTERPRETERS=

WORKDIR /zeppelin
RUN set -euo pipefail && \
    wget -O - https://archive.apache.org/dist/zeppelin/zeppelin-${ZEPPELIN_VERSION}/zeppelin-${ZEPPELIN_VERSION}-bin-netinst.tgz | \
        tar xz --strip-components=1 -C /zeppelin zeppelin-${ZEPPELIN_VERSION}-bin-netinst; \
    :

RUN set -euo pipefail && \
    wget http://central.maven.org/maven2/io/buji/buji-pac4j/4.1.0/buji-pac4j-4.1.0.jar; \
    wget http://central.maven.org/maven2/org/pac4j/pac4j-oauth/3.7.0/pac4j-oauth-3.7.0.jar; \
    wget http://central.maven.org/maven2/org/apache/shiro/shiro-web/1.4.1/shiro-web-1.4.1.jar; \
    wget http://central.maven.org/maven2/org/apache/shiro/shiro-core/1.4.1/shiro-core-1.4.1.jar; \
    :

RUN set -euo pipefail && \
    if [ -z "${OTHER_INTERPRETERS}" ]; then \
        interpreters_flag="" \
    else \
        interpreters_flag="--name ${OTHER_INTERPRETERS}" \
    fi; \
    ./bin/install-interpreter.sh ${interpreters_flag}; \
    :
