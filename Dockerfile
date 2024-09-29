FROM maven:3.9.4-eclipse-temurin-21-alpine
COPY . .
RUN mvn clean pakcage -DskipTests

FROM openjdk:21-slim
COPY --from=build target/todoapi-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-Dserver.port=${PORT}", "-jar", "app.jar"]
