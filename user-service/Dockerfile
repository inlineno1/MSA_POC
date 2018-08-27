FROM inlineno1/amazonlinux2:latest
MAINTAINER james lee <inlineno1@gmail.com>

ADD ./target/user-service.jar /app/
CMD ["java", "-Xmx200m", "-jar", "/app/user-service.jar"]

EXPOSE 8081