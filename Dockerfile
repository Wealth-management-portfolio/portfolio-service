# Stage 1: Build
FROM docker.io/library/eclipse-temurin:21-jdk AS builder

WORKDIR /app
COPY . .

RUN set -eux; \
    chmod +x gradlew; \
    ./gradlew clean bootJar --no-daemon -x test; \
    jar_file=""; \
    for file in build/libs/*.jar; do \
        case "$file" in \
            *-plain.jar) continue ;; \
            *) jar_file="$file"; break ;; \
        esac; \
    done; \
    test -n "$jar_file"; \
    cp "$jar_file" /app/portfolio-service.jar; \
    ls -lh /app/portfolio-service.jar


# Stage 2: Runtime
FROM docker.io/library/eclipse-temurin:21-jre

WORKDIR /app

COPY --from=builder /app/portfolio-service.jar ./portfolio-service.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "portfolio-service.jar"]