FROM docker.io/library/openjdk:21-ea AS builder
WORKDIR /app
COPY ./ /app/
RUN chmod +x gradlew \
    && ./gradlew clean bootJar --no-daemon -x test \
    && find build/libs -maxdepth 1 \
       -type f \
       -name "*.jar" \
       ! -name "*-plain.jar" \
       -exec cp {} /app/portfolio-service.jar \;

FROM docker.io/redhat/ubi9
COPY --from=builder /app/portfolio-service.jar ./portfolio-service.jar
ENTRYPOINT ["java", "-jar", "portfolio-service.jar"]