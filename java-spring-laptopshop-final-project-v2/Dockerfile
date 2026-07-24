# Stage 1: Build JAR bằng Maven
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Runtime JRE 17
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy file JAR vừa build sang
COPY --from=build /app/target/*.jar /app/app.jar

EXPOSE 8080

# Chạy trực tiếp file JAR và ép truyền PORT
ENTRYPOINT ["sh", "-c", "java -Xmx384m -Dserver.port=${PORT:-8080} -jar /app/app.jar"]