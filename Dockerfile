FROM openjdk:8-jdk-alpine

ARG IMAGE_CREATE_DATE
ARG IMAGE_VERSION
ARG IMAGE_SOURCE_REVISION

# Metadata as defined in OCI image spec annotations - https://github.com/opencontainers/image-spec/blob/master/annotations.md
LABEL org.opencontainers.image.title="Castor" \
      org.opencontainers.image.description="Java Spring PetClinic Sample Application for Kubernetes" \
      org.opencontainers.image.created=$IMAGE_CREATE_DATE \
      org.opencontainers.image.version=$IMAGE_VERSION \
      org.opencontainers.image.authors="Anthony Angelo" \
      org.opencontainers.image.url="https://github.com/pangealab/castor/" \
      org.opencontainers.image.documentation="https://github.com/pangealab/castor/README.md" \
      org.opencontainers.image.vendor="Anthony Angelo" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.source="https://github.com/pangealab/castor.git" \
      org.opencontainers.image.revision=$IMAGE_SOURCE_REVISION

# Install Tools
RUN apk add --update curl && \
    rm -rf /var/cache/apk/*

# Declare Ports
EXPOSE 8080

# Copy Java OTEL Launcher
RUN curl -L -O  https://github.com/lightstep/otel-launcher-java/releases/latest/download/lightstep-opentelemetry-javaagent.jar 

# Copy App Files
ADD target/app.jar app.jar
COPY run.sh run.sh

# Run Spring Boot
ENTRYPOINT ["./start.sh"]