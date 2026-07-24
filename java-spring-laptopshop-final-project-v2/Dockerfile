# Bước 1: Build file JAR bằng Maven
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests
# Xóa file jar phụ để đảm bảo chỉ còn duy nhất 1 file JAR chính
RUN rm -f target/*-plain.jar target/*-original.jar

# Bước 2: Chạy ứng dụng Java
FROM eclipse-temurin:17-jdk
WORKDIR /app
# Đường dẫn đã chuẩn trở lại và sẽ copy đúng 1 file đổi tên thành app.jar
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]