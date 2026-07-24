# Bước 1: Build file JAR bằng Maven
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Bước 2: Chạy ứng dụng Java
FROM eclipse-temurin:17-jdk
WORKDIR /app
# Chỉ định chính xác đường dẫn chứa file target từ bước build
COPY --from=build /app/java-spring-laptopshop-final-project-v2/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]