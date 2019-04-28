## This image will copy the jar file created and will run the app
## As we already have mvn installed on the VM it's easier to package the app there
## That way we can test the build in a CI system as well pretty quickly
## If we had maven package the app in the docker image, every time the CI builds it 
## maven will download all the deps thus increasing the build time

FROM openjdk:8-jdk-alpine
WORKDIR /app
ARG artifactid
ARG artver
ENV artifact=${artifactid}-${artver}-SNAPSHOT.jar
COPY ./example.yaml example.yaml
COPY ./target/${artifact} .
RUN adduser -D -u 1001 java && chown -R java /app
USER java

ENTRYPOINT ["sh", "-c"]
CMD ["/usr/bin/java -jar ${artifact} server example.yaml"]
