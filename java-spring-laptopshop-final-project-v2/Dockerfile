# Bước 1: Build file JAR bằng Maven
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Bước 2: Chạy ứng dụng Java
FROM eclipse-temurin:17-jdk
WORKDIR /app
# Copy toàn bộ thư mục target sang stage 2
COPY --from=build /app/target /app/target

EXPOSE 8080
# Chạy trực tiếp file .jar (loại trừ file -plain.jar nếu có)
ENTRYPOINT ["sh", "-c", "java -jar $(ls /app/target/*.jar | grep -v 'plain' | head -n 1)"]