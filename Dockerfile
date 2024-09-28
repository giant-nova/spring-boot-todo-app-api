FROM maven:3.9.4-eclipse-temurin-21-alpine AS build
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:21-slim
COPY --from=build target/todoapi-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080

ENV DATABASE_URL=jdbc:postgresql://todo_db_f9pw_user:HwaRKAzDusbRjln5tvXFyHLnHo3wTbaV@dpg-crs2jhggph6c738o8gfg-a.oregon-postgres.render.com:5432/todo_db_f9pw
ENV DB_USER=todo_db_f9pw_user
ENV DB_PASSWORD=HwaRKAzDusbRjln5tvXFyHLnHo3wTbaV

ENTRYPOINT ["java", "-Dspring.datasource.url=${DATABASE_URL}", "-Dspring.datasource.username=${DB_USER}", "-Dspring.datasource.password=${DB_PASSWORD}", "-jar", "app.jar"]