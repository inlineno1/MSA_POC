FROM inlineno1/amazonlinux2:latest
MAINTAINER james lee <inlineno1@gmail.com>

ADD ./target/hystrix.jar /app/
CMD ["java", "-Xmx200m", "-jar", "/app/hystrix.jar"]

EXPOSE 9000