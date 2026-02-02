FROM maven:3.9.12-eclipse-temurin-11-alpine AS build
WORKDIR /build
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:11-jre-ubi10-minimal
WORKDIR /app
COPY --from=build /build/target/*.jar  app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]