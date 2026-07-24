# Bước 1: Build WAR bằng Maven
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Bước 2: Runtime với JRE 17
FROM eclipse-temurin:17-jre
WORKDIR /app

COPY --from=build /app/target/*.war /app/app.war

EXPOSE 8080 10000

# Chạy app và truyền thẳng tham số PORT vào Spring Boot
ENTRYPOINT ["sh", "-c", "java -Xmx384m -Dserver.port=${PORT:-8080} -jar /app/app.war --server.port=${PORT:-8080}"]