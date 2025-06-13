# Stage 1: Build the Java application
FROM maven:3.8.3-openjdk-17 AS builder

WORKDIR /app

COPY . .

# Build the application and skip tests
RUN mvn clean install -DskipTests=true

# Stage 2: Run the application
FROM openjdk:17-alpine

WORKDIR /app

# Copy the generated JAR file from the builder stage
COPY --from=builder /app/target/*.jar /app/expenseapp.jar

# Run the application
CMD ["java", "-jar", "/app/expenseapp.jar"]
