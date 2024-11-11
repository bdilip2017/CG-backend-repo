# Backend Dockerfile
FROM maven:3.8.1-jdk-11 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package -DskipTests

FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/*.jar /app/backend.jar
ENTRYPOINT ["java", "-jar", "/app/backend.jar"]
EXPOSE 8080
