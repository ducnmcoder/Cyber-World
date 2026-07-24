# Stage 1: Build WAR bằng Maven
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Runtime JRE 17
FROM eclipse-temurin:17-jre
WORKDIR /app

COPY --from=build /app/target/*.war /app/app.war

EXPOSE 8080

# Thêm tham số urandom giúp Tomcat bind port siêu tốc
ENTRYPOINT ["sh", "-c", "java -Xmx384m -Djava.security.egd=file:/dev/./urandom -Dserver.port=${PORT:-8080} -jar /app/app.war"]