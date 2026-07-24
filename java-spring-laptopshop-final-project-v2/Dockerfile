# Bước 1: Build file JAR bằng Maven
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Bước 2: Chạy ứng dụng Java (Sửa lại đường dẫn tìm file .jar)
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=build /app/**/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]