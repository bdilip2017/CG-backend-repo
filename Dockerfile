# Backend Dockerfile for backend-repo

# Step 1: Use Maven to build the application
FROM maven:3.8.1-openjdk-11 AS build
WORKDIR /app

# Copy Maven configuration and source code
COPY pom.xml ./
COPY src ./src

# Build the application, creating a JAR file
RUN mvn clean package -DskipTests

# Step 2: Use a lightweight OpenJDK image to run the app
FROM openjdk:11-jre
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose port 8080 for the application
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

