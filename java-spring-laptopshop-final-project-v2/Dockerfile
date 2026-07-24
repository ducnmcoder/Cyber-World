# Stage 1: Build project
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Run Spring Boot
FROM maven:3.9-eclipse-temurin-17
WORKDIR /app
COPY --from=build /app .
EXPOSE 8080
ENTRYPOINT ["mvn", "spring-boot:run"]