# Builder stage, produces the compiled, packaged app code in a jar artifact
FROM eclipse-temurin:17-jdk-noble AS builder
WORKDIR /petclinic-rest
COPY .mvn/ .mvn/
COPY mvnw pom.xml ./
RUN ./mvnw dependency:go-offline
COPY src/ src/
RUN ./mvnw clean install

# Run stage, uses jar from previous stage
FROM eclipse-temurin:17-jre-noble AS final
RUN useradd appuser
RUN mkdir -p /logs/archived && chown -R appuser:appuser /logs
WORKDIR /petclinic-rest
EXPOSE 9966
COPY --from=builder /petclinic-rest/target/*.jar petclinic.jar
USER appuser
ENTRYPOINT ["java", "-jar", "petclinic.jar"]




