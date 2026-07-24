# Bước 1: Build file WAR gọn nhẹ bằng Maven
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Bước 2: Runtime siêu nhẹ bằng JDK 17 (Tiết kiệm RAM)
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy file WAR đã build ở Bước 1
COPY --from=build /app/target/*.war /app/app.war

EXPOSE 8080

# Chạy ứng dụng với giới hạn 384MB RAM (không bị tràn 512MB RAM của Render)
ENTRYPOINT ["java", "-Xmx384m", "-jar", "/app/app.war"]