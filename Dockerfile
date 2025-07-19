FROM ubuntu:24.10

RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y curl && \
    apt-get install -y unzip && \
    curl -s https://raw.githubusercontent.com/zaproxy/zap-admin/master/ZapVersions.xml | grep -P -o '(?<=<version>)[^<]+' | tail -1 > zapversion && \
    ZAPVERSION=`cat zapversion` && \
    curl -O https://github.com/zaproxy/zaproxy/releases/download/v${ZAPVERSION}/ZAP_${ZAPVERSION}_Linux.tar.gz && \
    tar -xzf ZAP_${ZAPVERSION}_Linux.tar.gz && \
    rm ZAP_${ZAPVERSION}_Linux.tar.gz && \
    ln -s /ZAP_${ZAPVERSION}/zap.sh /usr/local/bin/zap.sh

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
ENV PATH "$PATH:/ZAP_${ZAPVERSION}/"
EXPOSE 8090

