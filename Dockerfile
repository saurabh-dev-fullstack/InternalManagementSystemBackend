FROM eclipse-temurin:17-jdk

WORKDIR /app

# copy only needed files first (better caching)
COPY pom.xml .
COPY mvnw .
COPY .mvn .mvn

RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline

COPY src src

RUN ./mvnw clean package -DskipTests

CMD ["java", "-jar", "target/InternalManagementSystem-0.0.1-SNAPSHOT.jar"]