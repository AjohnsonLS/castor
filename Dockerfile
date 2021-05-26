FROM openjdk:8-jre

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

# Declare Ports
EXPOSE 8080

# Download Java OTEL Launcher
RUN curl -L -O  https://github.com/lightstep/otel-launcher-java/releases/latest/download/lightstep-opentelemetry-javaagent.jar 

# Copy App Files
ADD target/app.jar app.jar

# Lightstep Settings
# ENV LS_ACCESS_TOKEN=<<YOUR TOKEN>>
# ENV LS_SERVICE_NAME=<<YOUR SERVICE>>
# ENV LS_SERVICE_VERSION=<<YOUR VERSION>>

# Run Spring Boot
ENTRYPOINT ["java","-javaagent:lightstep-opentelemetry-javaagent.jar","-Xshare:off","-jar","/app.jar"]

# CMD ["catalina.sh", "run"]