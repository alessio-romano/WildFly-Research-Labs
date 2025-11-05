FROM eclipse-temurin:17-jdk-jammy AS builder

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl unzip ca-certificates \
    && rm -rf /var/lib/apt/lists/*

ENV WILDFLY_VERSION=37.0.0.Final \
    WILDFLY_HOME=/opt/wildfly

RUN curl -fsSL https://github.com/wildfly/wildfly/releases/download/${WILDFLY_VERSION}/wildfly-${WILDFLY_VERSION}.zip \
    -o /tmp/wildfly.zip \
    && unzip -q /tmp/wildfly.zip -d /opt \
    && mv /opt/wildfly-${WILDFLY_VERSION} ${WILDFLY_HOME} \
    && rm /tmp/wildfly.zip

ADD https://github.com/alessio-romano/WildFly-Research-Labs/raw/refs/heads/master/WARs/misconfigured_lab.war ${WILDFLY_HOME}/standalone/deployments/
ADD https://github.com/alessio-romano/WildFly-Research-Labs/raw/refs/heads/master/WARs/research_lab.war ${WILDFLY_HOME}/standalone/deployments/

ENV PATH=${WILDFLY_HOME}/bin:${PATH}

EXPOSE 8080

CMD ["standalone.sh", "-b", "0.0.0.0", "-secmgr"]
