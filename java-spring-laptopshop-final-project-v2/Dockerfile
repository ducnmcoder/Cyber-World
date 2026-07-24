# Bước 1: Build file WAR gọn nhẹ bằng Maven
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Bước 2: Runtime siêu nhẹ bằng JDK 17
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy file WAR đã build ở Bước 1
COPY --from=build /app/target/*.war /app/app.war

# Bắt buộc Spring Boot lắng nghe biến $PORT do Render cấp
ENTRYPOINT ["sh", "-c", "java -Xmx384m -Dserver.port=${PORT:-8080} -jar /app/app.war"]