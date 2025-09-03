# Stage 1: Build
FROM maven:3.9.3-eclipse-temurin-17 AS build

WORKDIR /app

# Copy pom first (so dependency cache is reused)
COPY pom.xml .

# Download dependencies (go offline mode)
RUN mvn dependency:go-offline -B

# Copy source code
COPY src ./src

# Build application JAR (skip tests for speed)
RUN mvn clean package -DskipTests

# Stage 2: Run
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy built JAR from build stage
COPY --from=build /app/target/*.ja*
