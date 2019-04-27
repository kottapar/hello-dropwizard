# Copying the pom.xml first and then pulling in the Maven dependencies
# This helps save them in Docker cache
FROM maven:3.5-jdk-8-alpine as build
COPY ./pom.xml ./pom.xml
RUN mvn dependency:go-offline
# We'll now copy the files that are prone to frequent changes
COPY ./src ./src
COPY ./example.yaml ./example.yaml
RUN mvn package

FROM openjdk:8-jdk-alpine
WORKDIR /app
ARG artifactid
ARG artver
ENV artifact=${artifactid}-${artver}-SNAPSHOT.jar
COPY --from=build example.yaml .
COPY --from=build target/${artifact} .
RUN adduser -D -u 1001 java && chown -R java /app
USER java
CMD ["/usr/bin/java -jar ${artifact} server example.yaml"]
