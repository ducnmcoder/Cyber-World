# Bước 1: Build file JAR gọn nhẹ
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
# Build ra file jar và bỏ qua test
RUN mvn clean package -DskipTests

# Bước 2: Runtime siêu nhẹ (chỉ dùng JDK 17, không cần Maven)
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy tất cả các file .jar trong target sang (Spring Boot WAR/JAR)
COPY --from=build /app/target/*.war /app/app.war 2>/dev/null || COPY --from=build /app/target/*.jar /app/app.jar

# Chạy ứng dụng bằng java -jar với giới hạn RAM tối đa 384MB để không bao giờ chạm trần 512MB của Render
EXPOSE 8080
ENTRYPOINT ["sh", "-c", "java -Xmx384m -jar /app/app.war 2>/dev/null || java -Xmx384m -jar /app/app.jar"]