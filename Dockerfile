# ---------- BUILD STAGE ----------
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn clean package -DskipTests

# ---------- RUNTIME STAGE ----------
FROM tomcat:9.0-jdk17-temurin

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Configure Tomcat to use Render PORT
RUN sed -i 's/port="8080"/port="${PORT}"/' /usr/local/tomcat/conf/server.xml

# Copy WAR
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
